//
//  AuthenticationView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// TODO: Login-Backend
// TODO: Refactor (move func to vm)
// TODO: Make textfields password and email tf

import SwiftUI

struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack {
                OnboardingIllustration("AuthenticationIllustration")
                
                Spacer()
                
                // Authentication
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        AuthenticationTextField(placeholder: "Email", textInput: $email)
                        AuthenticationTextField(placeholder: "Password", textInput: $password)
                    }
                    
                    OnboardingButton(destination: Text("Home"), title: "Sign in", isDisabled: credentialsMissing())
                }
                .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                // Registration
                OnboardingFlowChangeText(destination: NamePickerView(), question: "Don't have an account?", onboardingFlow: "Sign up")
            }
            .padding(.vertical)
        }
        .toolbar(.hidden)
    }
    
    func credentialsMissing() -> Bool {
        return email.isEmpty || password.isEmpty ? true : false
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView()
        }
    }
}
