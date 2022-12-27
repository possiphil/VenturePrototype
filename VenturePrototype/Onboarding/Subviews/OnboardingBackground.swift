//
//  OnboardingBackground.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct OnboardingBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("OnboardingGradientStart"), Color("OnboardingGradientEnd")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct OnboardingBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingBackground()
            OnboardingBackground()
                .preferredColorScheme(.dark)
        }
    }
}
