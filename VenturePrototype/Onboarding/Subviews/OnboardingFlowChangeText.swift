//
//  OnboardingFlowChangeText.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct OnboardingFlowChangeText<T: View>: View {
    let destination: T
    let question: String
    let onboardingFlow: String
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Text(question)
                    .foregroundColor(.primary)
                +
                Text(" ")
                +
                Text(onboardingFlow)
                    .bold()
                    .foregroundColor(Color("PrimaryAccentColor"))
            }
            .font(.callout)
        }
    }
}

struct OnboardingFlowChangeText_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowChangeText(destination: NamePickerView(), question: "Don't have an account?", onboardingFlow: "Sign up")
    }
}
