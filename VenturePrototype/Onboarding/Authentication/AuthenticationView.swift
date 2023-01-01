//
//  AuthenticationView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// MARK: Print error when changing from view textfield to alert textfield

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @State private var email = ""
    @State private var recoveryEmail = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var hasForgottenPassword = false
    
    @FocusState private var isFocusedOnEmail: Bool
    @FocusState private var isFocusedOnPassword: Bool
    
    private var shadow: Double {
        withAnimation(.spring()) {
            return credentialsMissing() ? 0 : 4
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
                .onTapGesture { removeKeyboardFocus() }
            
            // Content
            VStack {
                OnboardingIllustration("AuthenticationIllustration")
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
                            .focused($isFocusedOnEmail)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .fill(Color("PrimaryAccentColor"))
                            }
                            .onSubmit {
                                isFocusedOnPassword.toggle()
                            }
                        
                        CustomSecureField(placeholder: "Password", text: $password) {
                            authenticate()
                        }
                        .focused($isFocusedOnPassword)
                    }
                    
                    Button {
                        authenticate()
                    } label: {
                        Text("Sign in")
                            .foregroundColor(credentialsMissing() ? .secondary : .primary)
                            .frame(height: 52)
                            .frame(maxWidth: .infinity)
                            .background(
                                withAnimation(.easeInOut) {
                                    credentialsMissing() ? Color(.quaternaryLabel) : Color("PrimaryAccentColor")
                                }
                            )
                            .cornerRadius(12)
                            .shadow(radius: shadow)
                    }
                    .disabled(credentialsMissing())
                }
                .padding(.horizontal)
                
                Button {
                    recoveryEmail = email
                    hasForgottenPassword.toggle()
                } label: {
                    Text("Forgotten password?")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)
                        .padding(.vertical, 4)
                }
                
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
                OnboardingFlowChangeText(destination: NamePickerView(), question: "Don't have an account?", onboardingFlow: "Sign up")
            }
            .padding(.vertical)
        }
        .toolbar(.hidden)
        .alert("Reset Password", isPresented: $hasForgottenPassword) {
            TextField("Email", text: $recoveryEmail)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
            
            Button("Confirm") { resetPassword() }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enter your email address.")
        }
        .alert("Email has been sent", isPresented: $onboardingVM.hasSentEmail) {
            Button("Confirm", role: .cancel) { }
        }
        .alert("Please verify your email address", isPresented: $onboardingVM.didNotVerifyEmail) {
            Button("Resend email") { onboardingVM.sendEmailVerification() }
            Button("Confirm") { }
        }
    }
    
    func resetPassword() {
        onboardingVM.resetPassword(forEmail: recoveryEmail)
        email = recoveryEmail
        removeKeyboardFocus()
    }
    
    func removeKeyboardFocus() {
        isFocusedOnEmail = false
        isFocusedOnPassword = false
    }
    
    func credentialsMissing() -> Bool {
        return email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).count < 6 ? true : false
    }
    
    func authenticate() {
        Task {
            if !credentialsMissing() {
                isFocusedOnPassword = false
                await onboardingVM.authenticate(withEmail: email, password: password)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView()
        }
        .environmentObject(OnboardingVM())
    }
}
