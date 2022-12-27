//
//  VentureTextWithLogo.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct VentureTextWithLogo: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text("enture")
                .font(.title2)
        }
    }
}

struct VentureTextWithLogo_Previews: PreviewProvider {
    static var previews: some View {
        VentureTextWithLogo()
    }
}
