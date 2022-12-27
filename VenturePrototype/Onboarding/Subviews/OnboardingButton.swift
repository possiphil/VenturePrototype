//
//  AuthenticationButton.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct OnboardingButton<T: View>: View {
    let destination: T
    let title: String
    var isDisabled: Bool
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .foregroundColor(isDisabled ? .secondary : .primary)
                .frame(height: 52)
                .frame(maxWidth: .infinity)
                .background(isDisabled ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                .cornerRadius(12)
        }
        .disabled(isDisabled)
    }
}

struct AuthenticationButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton(destination: NamePickerView(), title: "Sign in", isDisabled: false)
    }
}
