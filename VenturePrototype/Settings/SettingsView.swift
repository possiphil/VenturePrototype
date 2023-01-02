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
            VStack {
                List {
                    Section("Account") {
                        Label("Edit Profile", systemImage: "person.crop.circle")
                        Label("Balance", systemImage: "creditcard")
                        Label("Earnings", systemImage: "dollarsign")
                        Label("Share profile", systemImage: "square.and.arrow.up")
                    }
                    
                    Section("Support") {
                        Label("Report a problem", systemImage: "square.and.pencil")
                    }
                    
                    Section("About") {
                        Label("Community Guidelines", systemImage: "person.3")
                        Label("Terms of Service", systemImage: "book")
                        Label("Privacy Policy", systemImage: "shield.righthalf.filled")
                        Label("Licenses", systemImage: "doc.text")
                        Label("Imprint", systemImage: "scroll")
                    }
                }
                
                Button("Log out", action: onboardingVM.signOut)
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
