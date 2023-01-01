//
//  CoreTabView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 28.12.22.
//

import SwiftUI

struct CoreTabView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    var body: some View {
        Button("Logout", action: onboardingVM.signOut)
    }
}

struct CoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabView()
    }
}
