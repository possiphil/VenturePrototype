//
//  EmailVerificationView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 29.12.22.
//
// https://stackoverflow.com/questions/65225001/how-to-check-if-users-email-is-verified

import SwiftUI

struct EmailVerificationView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @State private var hasVerified = false
    @State private var hasNotVerified = false
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack(spacing: 32) {
                OnboardingIllustration("VerificationIllustration")
                
                VStack {
                    Text("Please verify your email address and continue.")
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await onboardingVM.checkEmailVerification()
                            if onboardingVM.didVerifyEmail {
                                hasVerified.toggle()
                            } else {
                                hasNotVerified.toggle()
                            }
                        }
                    } label: {
                        Text("Continue")
                            .foregroundColor(.primary)
                            .frame(height: 52)
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryAccentColor"))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Email has been sent")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $hasVerified) {
            ImagePickerView()
        }
        .alert("Please verify your email address", isPresented: $onboardingVM.didNotVerifyEmail) {
            Button("Resend email") { onboardingVM.sendEmailVerification() }
            Button("Confirm") { }
        }
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailVerificationView()
                .environmentObject(OnboardingVM())
        }
    }
}
