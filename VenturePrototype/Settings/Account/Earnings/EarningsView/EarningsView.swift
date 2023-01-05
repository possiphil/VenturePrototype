//
//  EarningsView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct EarningsView: View {
    @StateObject var earningsVM = EarningsVM()
    
    var body: some View {
        VStack {
            BalanceHeaderView(balance: earningsVM.earnings)
            
            OnboardingIllustration("EarningsIllustration")
            
            Spacer()
            
            VStack(spacing: 8) {
                NavigationLink {
                    PaymentDetailsView()
                } label: {
                    Text("Withdraw")
                        .foregroundColor(earningsVM.earnings < 10_000 ? .secondary : .primary)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(earningsVM.earnings < 10_000 ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                        .cornerRadius(12)
                }
                .disabled(earningsVM.earnings < 10_000)
                
                Text("minimum 10.000 crowns")
                    .font(.footnote.bold())
                    .foregroundColor(Color(.systemRed))
            }
            .padding(.horizontal)
        }
        .navigationTitle("Earnings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EarningsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EarningsView()
        }
    }
}
