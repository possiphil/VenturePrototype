//
//  ImagePickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct ImagePickerView: View {
    @State private var profileImage: Image?
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    Text("Add a profile photo")
                        .font(.headline)
                    
                    OnboardingIllustration("ImagePickingIllustration")
                }
                
                Spacer()
                
                ImagePickerButton(profileImage: $profileImage)
                
                Spacer()
                
                VStack(spacing: 16) {
                    OnboardingButton(destination: Text("Home View"), title: "Continue", isDisabled: profileImage == nil)
                    
                    ContinueWithoutImageText()
                }
            }
            .padding()
        }
        .toolbar(.hidden)
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ImagePickerView()
        }
    }
}
