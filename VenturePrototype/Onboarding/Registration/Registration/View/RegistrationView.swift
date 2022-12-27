//
//  RegistrationView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack {
                OnboardingIllustration("RegistrationIllustration")
                
                Spacer()
                
                // Authentication
                VStack(spacing: 40) {
                    VStack(spacing: 16) {
                        AuthenticationTextField(placeholder: "Email", textInput: $email)
                        AuthenticationTextField(placeholder: "Password", textInput: $password)
                    }
                    
                    OnboardingButton(destination: ImagePickerView(), title: "Sign up", isDisabled: credentialsMissing())
                }
                .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                // Registration
                OnboardingFlowChangeText(destination: AuthenticationView(), question: "Already have an account?", onboardingFlow: "Sign in")
            }
            .padding(.vertical)
        }
        .toolbar(.hidden)
    }
    
    func credentialsMissing() -> Bool {
        return email.isEmpty || password.isEmpty ? true : false
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationView()
        }
    }
}
