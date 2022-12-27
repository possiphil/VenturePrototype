//
//  ImagePickerButton.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//


import SwiftUI

struct ImagePickerButton: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @Binding var profileImage: Image?
    
    var body: some View {
        Button {
            showImagePicker.toggle()
        } label: {
            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 5)
                            .fill(Color("SecondaryAccentColor"))
                    }
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 100))
                    .foregroundColor(Color("SecondaryAccentColor"))
                    .frame(width: 200, height: 200)
                    .background(Color("PrimaryAccentColor"))
                    .clipShape(Circle())
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            PhotoPicker(selectedImage: $selectedImage)
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ImagePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerButton(profileImage: .constant(nil))
    }
}
