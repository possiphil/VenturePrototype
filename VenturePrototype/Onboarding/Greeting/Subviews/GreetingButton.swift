//
//  GreetingButton.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import SwiftUI

struct GreetingButton<T: View>: View {
    let destination: T
    let title: String
    let color: Color
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundColor(.primary)
                .frame(height: 52)
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(12)
        }
    }
}

struct GreetingButton_Previews: PreviewProvider {
    static var previews: some View {
        GreetingButton(destination: AuthenticationView(), title: "Truth", color: Color(.systemGreen))
    }
}
