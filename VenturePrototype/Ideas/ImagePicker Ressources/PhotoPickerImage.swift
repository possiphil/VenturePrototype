//
//  PhotoPickerImage.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct PhotoPickerImage: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        Image(systemName: "plus.circle")
            .resizable()
            .frame(width: 200, height: 200)
            .scaledToFit()
            .fontWeight(.light)
            .foregroundColor(Color("SecondaryAccentColor"))
    }
}

struct PhotoPickerImage_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerImage()
    }
}
