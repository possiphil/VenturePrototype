//
//  PickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct PickerView: View {
    let title: String
    let textFieldPlaceholder: String
    
    @FocusState var textFieldFocused: Bool
    @Binding var textFieldInput: String
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack {
                Text(title)
                    .font(.headline)
                
                TextField(textFieldPlaceholder, text: $textFieldInput)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .focused($textFieldFocused)
                
                Spacer()
                
                OnboardingButton(destination: AgePickerView(), title: "Continue", isDisabled: textFieldInput.isEmpty)
            }
            .padding()
        }
        .toolbar(.hidden)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                textFieldFocused = true
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(title: "What's your name?", textFieldPlaceholder: "Your name", textFieldInput: .constant(""))
    }
}
