//
//  FirebaseError.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 01.01.23.
//
// TODO: Add reauthenticate errors when programming settings

import Foundation

enum FirebaseError: Error, LocalizedError {
    case networkError
    case userTokenExpired
    case tooManyRequests

    case serverError
    case registrationError
    case authenticationError
    case signOutError

    case userNotFound

    case invalidEmail
    case emailAlreadyInUse
    case unverifiedEmail

    case wrongPassword

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network Error"
        case .userTokenExpired:
            return "Session expired"
        case .tooManyRequests:
            return "Too many requests"
            
        case .serverError:
            return "Server Error"
        case .registrationError:
            return "Registration Error"
        case .authenticationError:
            return "Authentication Error"
        case .signOutError:
            return "Error signing out"
            
        case .userNotFound:
            return "User not found"
            
        case .invalidEmail:
            return "Invalid email address"
        case .emailAlreadyInUse:
            return "Email address already in use"
        case .unverifiedEmail:
            return "Email not verified"
            
        case .wrongPassword:
            return "Wrong password"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .networkError:
            return "Please check your internet connection."
        case .userTokenExpired:
            return "Please log in with your account again."
        case .tooManyRequests:
            return "Please try again later."
            
        case .serverError:
            return "Please try again later."
        case .registrationError:
            return "Please try again later."
        case .authenticationError:
            return "Please try again later."
        case .signOutError:
            return "Please try again later."
            
        case .userNotFound:
            return "Please try again later."
            
        case .invalidEmail:
            return "Please check your email address."
        case .emailAlreadyInUse:
            return "You can log in with this email address."
        case .unverifiedEmail:
            return "Please verify your email address."
            
        case .wrongPassword:
            return "Please check your password."
        }
    }
}
