//
//  UserError.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 29.12.22.
//
// MARK: DisplayNameErrors recoverable?

import Foundation

enum UserError: Error, LocalizedError {
    case registrationFailed
    case authenticationFailed
    case validationFailed
    
    case noInternetConnection
    
    case credentialsMissing
    
    case invalidBirthdate
    case tooYoung
    
    case usernameIsExplicit
    case usernameIsTaken
    
    case emailIsBadlyFormatted
    case emailIsAlreadyInUse
    case emailNotFound
    case sendingRecoveryEmailFailed
    case sendingVerificationEmailFailed
    case tooManyRecoveryEmailsSent
    case noAccountWithEmail
    
    case wrongPassword
    
    case settingDisplayNameFailed
    case gettingDisplayNameFailed
    
    case loadingImageFailed
    case savingImageFailed
    case compressingImageFailed
    case uploadingImageFailed
    
    var errorDescription: String? {
        switch self {
        case .registrationFailed:
            return "Registration failed"
        case .authenticationFailed:
            return "Authentication failed"
        case .validationFailed:
            return "Email validation failed"
            
        case .noInternetConnection:
            return "Missing internet connection"
            
        case .credentialsMissing:
            return "Credentials missing"
            
        case .invalidBirthdate:
            return "Invalid date"
        case .tooYoung:
            return "You are too young"
            
        case .usernameIsExplicit:
            return "Username contains explicit words"
        case .usernameIsTaken:
            return "Username is already taken"
            
        case .emailIsBadlyFormatted:
            return "Email is badly formatted"
        case .emailIsAlreadyInUse:
            return "Email is already in use"
        case .emailNotFound:
            return "Email not found"
        case .sendingRecoveryEmailFailed:
            return "Failed to send recovery email"
        case .sendingVerificationEmailFailed:
            return "Failed to send verification email"
        case .tooManyRecoveryEmailsSent:
            return "Recovery email limit reached"
        case .noAccountWithEmail:
            return "There is no account with this email address"
            
        case .wrongPassword:
            return "Wrong password"
          
        case .settingDisplayNameFailed:
            return "Failed to set username"
        case .gettingDisplayNameFailed:
            return "Failed to get username"
           
        case .loadingImageFailed:
            return "Failed to load image"
        case .compressingImageFailed:
            return "Failed to compress image"
        case .savingImageFailed:
            return "Failed to save image"
        case .uploadingImageFailed:
            return "Failed to upload image"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .registrationFailed:
            return "Please try again later."
        case .authenticationFailed:
            return "Please try again later."
        case .validationFailed:
            return "Please try again later."
            
        case .noInternetConnection:
            return "Please check your internet connection."
            
        case .credentialsMissing:
            return "Please restart registration process and try again."
            
        case .invalidBirthdate:
            return "Please provide your real birthday."
        case .tooYoung:
            return "You need to be at least 13 years old to use Venture."
            
        case .usernameIsExplicit:
            return "Explicit words are prohibited."
        case .usernameIsTaken:
            return "Your chosen username is already used by someone else."
            
        case .emailIsBadlyFormatted:
            return "Please revise your email address and try again."
        case .emailIsAlreadyInUse:
            return "There is already an account using this email address."
        case .emailNotFound:
            return "Please revise your email address and try again."
        case .sendingRecoveryEmailFailed:
            return "Please try again later."
        case .sendingVerificationEmailFailed:
            return "Please try again later."
        case .tooManyRecoveryEmailsSent:
            return "Please try again later."
        case .noAccountWithEmail:
            return "There is no account with this email address."
            
        case .wrongPassword:
            return "Please revise your password and try again."
            
        case .settingDisplayNameFailed:
            return "Please try again later."
        case .gettingDisplayNameFailed:
            return "Please re-authenticate."
           
        case .loadingImageFailed:
            return "Please try again later."
        case .savingImageFailed:
            return "Please clean up some space on your device."
        case .compressingImageFailed:
            return "Please try again later."
        case .uploadingImageFailed:
            return "Please try again later"
        }
    }
}

//struct ErrorType: Identifiable {
//    let id = UUID()
//    let error: UserError
//}
