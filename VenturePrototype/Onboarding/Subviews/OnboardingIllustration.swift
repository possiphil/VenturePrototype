//
//  OnboardingIllustration.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct OnboardingIllustration: View {
    let imageName: String
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 4)
    }
}

struct AuthenticationIllustration_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIllustration("AuthenticationIllustration")
    }
}
