//
//  BalanceHeaderView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct BalanceHeaderView: View {
    let balance: Int
    
    var body: some View {
        HStack {
            Image("crown_platinum")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
            Text(balance, format: .number)
                .font(.largeTitle)
                .bold()
        }
        .padding(.vertical, 48)
    }
}

struct BalanceHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceHeaderView(balance: 100)
    }
}
