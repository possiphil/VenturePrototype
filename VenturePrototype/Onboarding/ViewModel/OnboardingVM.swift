//
//  OnboardingVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//
// MARK: Handle errors

import CoreData
import Firebase
import FirebaseStorage // remove when refactored
import SwiftUI

class OnboardingVM: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var tempUserSession: Firebase.User?
    @Published var currentUser: User?
    @Published var registeringUser: RegisteringUser
    
    @Published var didRegisterUser = false
    // TODO: Change values to enum or single bool
    @Published var didNotVerifyEmail = false
    @Published var didVerifyEmail = false
    @Published var showProgressView = false
    @Published var hasSentEmail = false
    
    @Published var error: Swift.Error?
    
    private let userService = UserService()
    
    init() {
        self.registeringUser = RegisteringUser()
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    // MARK: Register user
    func register(withEmail email: String, password: String, name: String, birthday: Date, username: String) {
        showProgressView = true
        
        self.checkAvailability(of: username) { available in
            if !available { return self.publishError(UserError.usernameIsTaken) }
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                let error = err as NSError
                
                switch error.code {
                case AuthErrorCode.networkError.rawValue:
                    self.publishError(FirebaseError.networkError)
                case AuthErrorCode.tooManyRequests.rawValue:
                    self.publishError(FirebaseError.tooManyRequests)
                case AuthErrorCode.invalidEmail.rawValue:
                    self.publishError(FirebaseError.invalidEmail)
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.publishError(FirebaseError.emailAlreadyInUse)
                default:
                    self.publishError(FirebaseError.registrationError)
                }
                
                return
            }
            
            guard let user = result?.user else { return self.publishError(FirebaseError.userNotFound) }
            self.tempUserSession = user
            
            let data: [String: Any] = ["birthday": birthday,
                        "email":    email,
                        "id":       user.uid,
                        "name":     name]
            
            if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                currentUser.displayName = username
                currentUser.commitChanges { error in
                    if let err = error {
                        let error = err as NSError
                        
                        switch error.code {
                        case AuthErrorCode.networkError.rawValue:
                            self.publishError(FirebaseError.networkError)
                        case AuthErrorCode.tooManyRequests.rawValue:
                            self.publishError(FirebaseError.tooManyRequests)
                        case AuthErrorCode.userNotFound.rawValue:
                            self.publishError(FirebaseError.userNotFound)
                        default:
                            self.publishError(FirebaseError.registrationError)
                        }
                        
                        return
                    }
                    
                    guard let userDisplayName = user.displayName else { return self.publishError(FirebaseError.userNotFound) }
                    
                    Firestore.firestore().collection("users").document(userDisplayName)
                        .setData(data) { _ in
                            self.didRegisterUser = true
                            self.showProgressView = false
                        }
                    
                    self.sendEmailVerification()
                }
            } else {
                return self.publishError(FirebaseError.userNotFound)
            }
        }
    }
    
    // MARK: Check availability of username
    func checkAvailability(of username: String, completion: @escaping(Bool) -> Void) {
        let collection = Firestore.firestore().collection("users")
        
        collection.getDocuments { snapshot, error in
            if let err = error {
                let error = err as NSError
                
                switch error.code {
                case AuthErrorCode.networkError.rawValue:
                    self.publishError(FirebaseError.networkError)
                default:
                    self.publishError(FirebaseError.serverError)
                }
                
                return
            }
            
            guard let documents = snapshot?.documents else { return self.publishError(FirebaseError.serverError) }
            
            for document in documents {
                if username.lowercased() == document.documentID.lowercased() {
                    return completion(false)
                }
            }
            
            completion(true)
        }
    }
    
    // MARK: Check explicitness of username
    func checkExplicitness(of username: String, completion: @escaping() -> Void) {
        FilterService().filteredData(of: username) { result in
            if result.contains("*") { return self.publishError(UserError.usernameIsExplicit) }
            
            completion()
        }
    }
    
    // MARK: Send email verification
    func sendEmailVerification() {
        guard let user = Auth.auth().currentUser else { return self.publishError(FirebaseError.userNotFound) }
        Auth.auth().useAppLanguage()
        
        user.sendEmailVerification { error in
            if let err = error {
                let error = err as NSError
                
                switch error.code {
                case AuthErrorCode.userNotFound.rawValue:
                    self.publishError(FirebaseError.userNotFound)
                case AuthErrorCode.tooManyRequests.rawValue:
                    self.publishError(FirebaseError.tooManyRequests)
                case AuthErrorCode.networkError.rawValue:
                    self.publishError(FirebaseError.networkError)
                case AuthErrorCode.invalidEmail.rawValue:
                    self.publishError(FirebaseError.invalidEmail)
                default:
                    self.publishError(UserError.sendingVerificationEmailFailed)
                }
                
                return
            }
        }
    }
    
    // MARK: Check if email is verified
    @MainActor
    func checkEmailVerification() async {
        guard let user = Auth.auth().currentUser else { return publishError(FirebaseError.userNotFound) }
        
        do {
            try await user.reload()
            
            if user.isEmailVerified {
                didVerifyEmail = true
            } else {
                didNotVerifyEmail = true
            }
            showProgressView = false
        } catch {
            publishError(UserError.validationFailed)
        }
    }
    
    // MARK: Authenticate user
    @MainActor
    func authenticate(withEmail email: String, password: String) async {
        showProgressView = true
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = result.user
            
            await checkEmailVerification()
            
            if didVerifyEmail {
                self.userSession = user
                self.fetchUser()
                self.showProgressView = false
            }
        } catch {
            let err = error as NSError
            
            switch err.code {
            case AuthErrorCode.networkError.rawValue:
                self.publishError(FirebaseError.networkError)
            case AuthErrorCode.tooManyRequests.rawValue:
                self.publishError(FirebaseError.tooManyRequests)
            case AuthErrorCode.invalidEmail.rawValue:
                self.publishError(FirebaseError.invalidEmail)
            case AuthErrorCode.wrongPassword.rawValue:
                self.publishError(FirebaseError.wrongPassword)
            case AuthErrorCode.userNotFound.rawValue:
                self.publishError(FirebaseError.userNotFound)
            default:
                self.publishError(FirebaseError.authenticationError)
            }
        }
    }
    
    // MARK: Reset user password - Error Handling (User token expired)?
    func resetPassword(forEmail email: String) {
        Auth.auth().useAppLanguage()
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let err = error {
                let error = err as NSError
                
                switch error.code {
                case AuthErrorCode.userNotFound.rawValue:
                    self.publishError(FirebaseError.userNotFound)
                case AuthErrorCode.tooManyRequests.rawValue:
                    self.publishError(FirebaseError.tooManyRequests)
                case AuthErrorCode.networkError.rawValue:
                    self.publishError(FirebaseError.networkError)
                case AuthErrorCode.invalidEmail.rawValue:
                    self.publishError(FirebaseError.invalidEmail)
                default:
                    self.publishError(UserError.sendingRecoveryEmailFailed)
                }
                
                return
            }
            
            self.hasSentEmail.toggle()
        }
    }
    
    // MARK: Upload user profile image
    func uploadProfileImage(_ image: UIImage?, context: NSManagedObjectContext) {
        guard let image = image else { return publishError(UserError.loadingImageFailed) }
        
        let storageRef = Storage.storage().reference()
        
        guard let data = image.jpegData(compressionQuality: 0.1) else { return publishError(UserError.compressingImageFailed) }
        let savedImage = ProfileImage(context: context)
        savedImage.imageData = data
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            publishError(UserError.savingImageFailed)
        }
        
        guard let displayName = tempUserSession?.displayName else { return publishError(FirebaseError.userNotFound) }

        let fileRef = storageRef.child("profileImages/\(displayName).jpg")
        
        fileRef.putData(data) { _, error in
            if let err = error {
                let error = err as NSError
                
                switch error.code {
                case AuthErrorCode.networkError.rawValue:
                    self.publishError(FirebaseError.networkError)
                default:
                    self.publishError(FirebaseError.serverError)
                }
                
                return
            }
            
            self.userSession = self.tempUserSession
            self.tempUserSession = nil
            // self.fetchUsers()
        }
    }
    
    // MARK: Sign out user
    func signOut() {
        do {
            try Auth.auth().signOut()
            userSession = nil
        } catch {
            publishError(FirebaseError.signOutError)
        }
    }
    
    // MARK: Fetch user - Error Handling
    func fetchUser() {
        guard let displayName = self.userSession?.displayName else { return }
        
        userService.fetchUser(withDisplayName: displayName) { user in
            self.currentUser = user
        }
    }
    
    // MARK: Publish error
    func publishError(_ error: Error) {
        self.error = error
        showProgressView = false
    }
}
