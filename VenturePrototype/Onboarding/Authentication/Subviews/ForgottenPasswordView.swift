//
//  ForgottenPasswordView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct ForgottenPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var textFieldFocused: Bool
    @State private var email = ""
    @State private var isShowingConfirmation = false
    
    var body: some View {
        ZStack {
            Color("PrimaryBackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Please enter your email address.")
                    .font(.headline)
                
                AuthenticationTextField(placeholder: "Email", textInput: $email)
                    .focused($textFieldFocused)
                
                Spacer()
                
                Button {
                    isShowingConfirmation.toggle()
                } label: {
                    Text("Reset Password")
                        .foregroundColor(email.isEmpty ? .secondary : .primary)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(email.isEmpty ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                        .cornerRadius(12)
                }
                .disabled(email.isEmpty)
            }
            .padding()
            .padding(.top, 8)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                textFieldFocused = true
            }
        }
        .alert("Email has been sent", isPresented: $isShowingConfirmation) {
            Button("Confirm", role: .cancel) { dismiss() }
        }
    }
}

struct ForgottenPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgottenPasswordView()
    }
}
