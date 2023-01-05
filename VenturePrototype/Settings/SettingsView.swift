//
//  SettingsView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var onboardingVM: OnboardingVM
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    NavigationLink{ EditProfileView() } label: { Label("Edit Profile", systemImage: "person.crop.circle") }
                        .foregroundColor(.primary)
                    NavigationLink{ BalanceView() } label: { Label("Balance", systemImage: "creditcard") }
                        .foregroundColor(.primary)
                    NavigationLink{ EarningsView() } label: { Label("Earnings", systemImage: "dollarsign") }
                        .foregroundColor(.primary)
//                    Label("Share profile", systemImage: "square.and.arrow.up")
                }
                
                Section("Support") {
                    NavigationLink{ BugReportView() } label: { Label("Report a problem", systemImage: "square.and.pencil") }
                        .foregroundColor(.primary)
                }
                
                Section("About") {
                    NavigationLink{ CommunityGuidelinesView() } label: { Label("Community Guidelines", systemImage: "person.3") }
                        .foregroundColor(.primary)
                    NavigationLink{ TermsOfServiceView() } label: { Label("Terms of Service", systemImage: "book") }
                        .foregroundColor(.primary)
                    NavigationLink{ PrivacyPolicyView() } label: { Label("Privacy Policy", systemImage: "shield.lefthalf.filled") }
                        .foregroundColor(.primary)
                    
                    Label("Licenses", systemImage: "doc.text")
                    Label("Imprint", systemImage: "scroll")
                }
                
                HStack {
                    Spacer()
                    Button("Log out", action: onboardingVM.signOut)
                    Spacer()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
                .environmentObject(OnboardingVM())
        }
    }
}
