//
//  PurchaseScrollView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct PurchaseScrollView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Buy crowns")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ForEach(Bundles.allCases, id: \.self) { bundle in
                    VStack {
                        PurchaseCell(imageName: bundle.crownImage, crownAmount: bundle.crownAmount, extraCrowns: bundle.extraCrowns, price: bundle.price)
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
    }
}

struct PurchaseScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseScrollView()
    }
}
