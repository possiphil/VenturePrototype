//
//  ContinueWithoutImageText.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct ContinueWithoutImageText: View {
    var body: some View {
        NavigationLink {
            Text("Home View")
        } label: {
            Text("Continue without profile photo")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

struct ContinueWithoutImageText_Previews: PreviewProvider {
    static var previews: some View {
        ContinueWithoutImageText()
    }
}
