//
//  GreetingView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// TODO: Make Truth or Dare look better

import SwiftUI

struct GreetingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                OnboardingBackground()
                
                // Content
                VStack {
                    Text("Welcome!")
                        .font(.largeTitle.bold())
                        .padding(.top)
                    
                    OnboardingIllustration("GreetingIllustration")
                        .padding(.top)
                    
                    Spacer()
                    
                    // Onboarding Flow
                    VStack(spacing: 20) {
                        GreetingButton(destination: AuthenticationView(), title: "Truth", color: Color(.systemGreen))
                        
                        Text("or")
                            .font(.title3)
                            .foregroundColor(.primary)
                        
                        GreetingButton(destination: NamePickerView(), title: "Dare", color: Color(.systemRed))
                    }
                    .padding()
                }
            }
        }
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
