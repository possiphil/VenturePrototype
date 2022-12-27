//
//  PhotoPicker.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                #warning("Check compressionQuality before shipping")
                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else { return } //can return error
                photoPicker.selectedImage = compressedImage
            } else {
                // TODO: return error / show alert (user didn't pick an image or something went wrong)
            }
            picker.dismiss(animated: true)
        }
    }
}
