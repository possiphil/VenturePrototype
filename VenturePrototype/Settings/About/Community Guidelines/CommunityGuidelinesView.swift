//
//  CommunityGuidelinesView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//
// Twitch: https://safety.twitch.tv/s/article/Community-Guidelines?language=en_US
// Youtube: https://www.youtube.com/howyoutubeworks/policies/community-guidelines/
// Facebook: https://transparency.fb.com/en-gb/policies/community-standards/
// Instagram: https://www.facebook.com/help/477434105621119
// TikTok: https://www.tiktok.com/community-guidelines?lang=en

import SwiftUI

struct CommunityGuidelinesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                CGIntroductionView()
                
                CGSafetyView()
                
                CGLegitimacyView()
                
                CGCivilityView()
                
                CGAuthenticityView()
                
                CGSensitiveContentView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Community Guidelines")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommunityGuidelinesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommunityGuidelinesView()
        }
    }
}
