//
//  ImagePickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// TODO: Add ProgressView on top of image to show loading (is this necessary?)

import SwiftUI

struct ImagePickerView: View {
    @EnvironmentObject var onboardingVM: OnboardingVM
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    @State private var hasPressedContinue = false
    
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
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    ZStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color("SecondaryAccentColor"))
                            .frame(width: 200, height: 200)
                            .background(Color("PrimaryAccentColor"))
                            .clipShape(Circle())
                        
//                        if showProgressView {
//                            ProgressView()
//                        }
                        
                        profileImage?
                            .resizable()
                            .frame(width: 200, height: 200)
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .fill(Color("SecondaryAccentColor"))
                            }
                    }
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Button {
                        onboardingVM.uploadProfileImage(selectedImage)
                    } label: {
                        Text("Continue")
                            .foregroundColor(isProfileImageMissing() ? .secondary : .primary)
                            .frame(height: 52)
                            .frame(maxWidth: .infinity)
                            .background(isProfileImageMissing() ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                            .cornerRadius(12)
                    }
                    .disabled(isProfileImageMissing())
                    
                    ContinueWithoutImageText()
                }
            }
            .padding()
        }
        .toolbar(.hidden)
        .onChange(of: selectedImage) { _ in loadImage() }
        .sheet(isPresented: $showImagePicker) {
            PhotoPicker(selectedImage: $selectedImage)
        }
    }
    
    func isProfileImageMissing() -> Bool {
        return profileImage == nil
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return onboardingVM.publishError(UserError.loadingImageFailed) }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ImagePickerView()
        }
    }
}
