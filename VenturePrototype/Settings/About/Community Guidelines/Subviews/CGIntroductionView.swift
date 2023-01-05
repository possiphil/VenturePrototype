//
//  CGIntroductionView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGIntroductionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Introduction")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Text("Last updated, 3rd January 2023")
                .font(.footnote.italic())
                .foregroundColor(.secondary)
            
            Text("Our mission at Venture is to make the most comfortable uncomfortable experience with livestreaming and our dare system available to every user, no matter of their background, religion, belief or any other differentiation from others. This is only achievable with your help!")
                .font(.callout)
            
            Text("We want Venture to be an authentic and safe place for growth, expression and inspiration. To provide a safe and enjoyable interaction between users, we need any participant to act in a way that promotes a positive experience for our community.")
                .font(.callout)
            
            Text("These guidelines set the guardrails for what behaviour is and is not allowed on Venture. They apply to everyone and everything on our service. We are committed to these guidelines and hope that you are too.")
                .font(.callout)
            
            Text("Overstepping our boundaries may result in disabled accounts, deleted content or other restrictions. Every user may be provided with equal protections under this policy. The instances of action against any violation of these guidelines may differ depending on severity, type, details and frequency of the violation. Individuals are notified of our decisions and can appeal them if they believe no violation has occurred. We recognize that some content may be in the public interest and therefore may allow exceptions under certain limited circumstances.")
                .font(.callout)
            
            Text("To keep up with the evolving behaviours and risks, we update our Community Guidelines from time to time.")
                .font(.callout)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        CGIntroductionView()
    }
}
