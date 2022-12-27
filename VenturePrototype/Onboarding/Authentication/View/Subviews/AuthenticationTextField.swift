//
//  AuthenticationTextField.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct AuthenticationTextField: View {
    let placeholder: String
    @Binding var textInput: String
    
    var body: some View {
        TextField(placeholder, text: $textInput)
            .frame(height: 52)
            .padding(.horizontal)
            .background(Color("PrimaryAccentColor").opacity(0.1))
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .fill(Color("PrimaryAccentColor"))
            }
    }
}
