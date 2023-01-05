//
//  BalanceView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//
// TODO: Check how to write extra crowns to be legally safe
// TODO: Display real price values instead of just double with currency code
// MARK: Display crown image based on balance?

import SwiftUI

struct BalanceView: View {
    var body: some View {
        VStack(spacing: 0) {
            BalanceHeaderView(balance: 100)
            
            Divider()
            
            PurchaseScrollView()
            
            Divider()
            
            BalanceLegalNotice()
                .font(.footnote)
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
        .navigationTitle("Balance")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BalanceView()
        }
    }
}
