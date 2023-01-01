//
//  LaunchScreenView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//
// TODO: Improvement - Make transition to content view when user logs in (eg dismiss to bottom)

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            Group {
                if onboardingVM.userSession?.isEmailVerified == true {
                    CoreTabView()
                } else {
                    GreetingView()
                }
            }
        } else {
            ZStack {
                Color("SecondaryAccentColor")
                    .ignoresSafeArea()
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.size = 1.2
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(OnboardingVM())
    }
}
