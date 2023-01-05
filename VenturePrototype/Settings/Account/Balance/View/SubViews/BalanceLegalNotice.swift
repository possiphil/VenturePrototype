//
//  BalanceLegalNotice.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct BalanceLegalNotice: View {
    var body: some View {
        Text("Proceeding with your purchase, you agree to our ")
        +
        Text("Terms of Sale")
            .foregroundColor(.blue)
        +
        Text(" and ")
        +
        Text("Crowns Terms")
            .foregroundColor(.blue)
        +
        Text(".")
    }
}

struct BalanceLegalNotice_Previews: PreviewProvider {
    static var previews: some View {
        BalanceLegalNotice()
    }
}
