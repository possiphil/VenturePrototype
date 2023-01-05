//
//  PurchaseCell.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct PurchaseCell: View {
    let imageName: String
    let crownAmount: Int
    let extraCrowns: Int?
    let price: Double
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading) {
                    Text("\(crownAmount) crowns")
                    
                    if let extraCrowns = extraCrowns {
                        Text("\(extraCrowns) crowns extra!")
                            .font(.caption.bold())
                            .foregroundColor(.green)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text(price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.callout.bold())
                        .foregroundColor(.primary)
                        .frame(width: 112, height: 44)
                        .background(Color(.systemRed))
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct PurchaseCell_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseCell(imageName: "crown_bronze", crownAmount: 205, extraCrowns: 5 , price: 5.99)
    }
}
