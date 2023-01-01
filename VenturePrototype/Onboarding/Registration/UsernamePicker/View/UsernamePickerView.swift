//
//  UsernamePickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// MARK: Toolbar is cramped

import Combine
import SwiftUI

struct UsernamePickerView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @FocusState private var textFieldFocused: Bool
    
    @State private var textFieldInput = ""
    @State private var hasSubmitted = false
    @State private var isUsernameAvailable = false
    @State private var isDisabled = true

    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack {
                TextField("Username", text: $textFieldInput)
                    .font(.largeTitle)
                    .foregroundColor(isUsernameAvailable ? Color(.systemGreen) : Color(.systemRed))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .autocorrectionDisabled()
                    .focused($textFieldFocused)
                    .onReceive(Just(textFieldInput)) { newValue in
                        let filtered = newValue.filter { Set("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-_").contains($0) }
                        if filtered != newValue {
                            self.textFieldInput = filtered
                        }
                    }
                    .onChange(of: textFieldInput) { newValue in
                        guard textFieldInput.isNotEmpty else { return isDisabled = true }
                        
                        onboardingVM.checkAvailability(of: textFieldInput) { available in
                            if available {
                                isUsernameAvailable = true
                                isDisabled = false
                            } else {
                                isUsernameAvailable = false
                                isDisabled = true
                            }
                        }
                    }
                    .onSubmit {
                        submit()
                    }
                
                Spacer()
                
                Button {
                    submit()
                } label: {
                    Text("Continue")
                        .foregroundColor(isDisabled ? .secondary : .primary)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(isDisabled ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                        .cornerRadius(12)
                }
                .disabled(isDisabled)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("What do you want to be called?")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $hasSubmitted, destination: {
            RegistrationView()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    AuthenticationView()
                } label: {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(Color("PrimaryAccentColor"))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                textFieldFocused = true
            }
        }
        .errorAlert(error: $onboardingVM.error)
    }
    
    func submit() {
        if textFieldInput.isNotEmpty {
            onboardingVM.checkAvailability(of: textFieldInput) { available in
                if !available { return }
            }
            onboardingVM.checkExplicitness(of: textFieldInput) {
                DispatchQueue.main.async {
                    onboardingVM.registeringUser.username = textFieldInput
                    hasSubmitted.toggle()
                }
            }
        }
    }
}

struct UsernamePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UsernamePickerView()
        }
    }
}
