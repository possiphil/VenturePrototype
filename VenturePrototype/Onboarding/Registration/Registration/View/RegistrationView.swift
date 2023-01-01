//
//  RegistrationView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// MARK: Keyboard "wobbles" when changing focus

import Combine
import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @State private var email = ""
    @State private var password = ""
    @State private var hasRegistered = false
    
    @FocusState private var isFocusedOnEmail: Bool
    @FocusState private var isFocusedOnPassword: Bool
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
                .onTapGesture { removeKeyboardFocus() }
            
            // Content
            VStack {
                OnboardingIllustration("RegistrationIllustration")
                    .onTapGesture { removeKeyboardFocus() }
                
                Spacer()
                
                // Authentication
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .frame(height: 52)
                            .padding(.horizontal)
                            .background(Color("PrimaryAccentColor").opacity(0.1))
                            .cornerRadius(12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .fill(Color("PrimaryAccentColor"))
                            }
                            .onSubmit {
                                isFocusedOnPassword.toggle()
                            }
                        
                        CustomSecureField(placeholder: "Password (min 6 characters)", text: $password) {
                            register()
                        }
                        .focused($isFocusedOnPassword)
                    }
                    
                    Button {
                        register()
                    } label: {
                        Text("Sign up")
                            .foregroundColor(credentialsMissing() ? .secondary : .primary)
                            .frame(height: 52)
                            .frame(maxWidth: .infinity)
                            .background(credentialsMissing() ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                            .cornerRadius(12)
                    }
                    .disabled(credentialsMissing())

                }
                .padding(.horizontal)
                
                Spacer()
                
                if onboardingVM.showProgressView {
                    ProgressView()
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 0, height: 20)
                }
                
                Spacer()
                
                // Registration
                OnboardingFlowChangeText(destination: AuthenticationView(), question: "Already have an account?", onboardingFlow: "Sign in")
            }
            .padding(.vertical)
        }
        .toolbar(.hidden)
        .navigationDestination(isPresented: $onboardingVM.didRegisterUser) {
            EmailVerificationView()
        }
        .errorAlert(error: $onboardingVM.error)
    }
    
    func register() {
        if !credentialsMissing() {
            isFocusedOnPassword = false
            
            guard let name = onboardingVM.registeringUser.name else { return onboardingVM.publishError(UserError.credentialsMissing) }
            guard let birthday = onboardingVM.registeringUser.birthday else { return onboardingVM.publishError(UserError.credentialsMissing) }
            guard let username = onboardingVM.registeringUser.username else { return onboardingVM.publishError(UserError.credentialsMissing) }
            
            onboardingVM.register(withEmail: email, password: password, name: name, birthday: birthday, username: username)
        }
    }
    
    func credentialsMissing() -> Bool {
        return email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).count < 6 ? true : false
    }
    
    func removeKeyboardFocus() {
        isFocusedOnEmail = false
        isFocusedOnPassword = false
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationView()
                .environmentObject(OnboardingVM())
        }
    }
}
