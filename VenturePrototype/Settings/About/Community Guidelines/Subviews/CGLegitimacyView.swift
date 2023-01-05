//
//  CGLegitimacyView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGLegitimacyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Legitimacy")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Group {
                Text("Breaking the law")
                    .font(.title3.bold())
                
                Text("You are in need to respect all applicable local, national, and international laws while using our service and therefore any activity or content that features, encourages, solicits, or offers illegal activity is prohibited and may be reported to law enforcement.")
                    .font(.callout)
            }
            
            Group {
                Text("Fraud")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("We disallow anyone to deceive people in order to gain an unlawful financial or personal advantage.")
                    .font(.callout)
            }
            
            Group {
                Text("Intellectual Property Rights")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Sharing content that you do not own or do not have the rights to share on Venture is not permitted and may be subject to a takedown by the rights holder(s).")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGLegitimacyView_Previews: PreviewProvider {
    static var previews: some View {
        CGLegitimacyView()
    }
}
