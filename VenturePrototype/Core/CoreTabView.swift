//
//  CoreTabView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 28.12.22.
//
// MARK: Move Stream view to topLeading?
// MARK: Implement Loading screen when video loads

import SwiftUI

struct CoreTabView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                    .toolbarColorScheme(.dark, for: .tabBar)
                
    //            DiscoverView()
    //                .tabItem {
    //                    Image(systemName: "binoculars")
    //                }
    //                .tag(1)
                
                StreamingView()
                    .tabItem {
                        Image(selectedTab == 1 ? (colorScheme == .light ? "livestreamBlack" : "livestreamWhite") : "livestreamSecondary")
                    }
                    .tag(1)
                
                InboxView()
                    .tabItem {
                        Image(systemName: "tray")
                    }
                    .tag(2)
                
                ProfileView(user: User(id: "1234", name: "", birthday: .now, userBio: ""))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
                    .tag(3)
            }
            .tint(selectedTab == 0 ? .white : .primary)
            .toolbar(.hidden)
        }
        
    }
}

struct CoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabView()
    }
}


