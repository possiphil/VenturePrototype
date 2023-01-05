//
//  StreamView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import AVKit
import SwiftUI

struct StreamView: View {
    let streamUrl: String
    
    @EnvironmentObject var vm: HomeVM
    
    @State private var player: AVPlayer?
    @State private var chatMessage = ""
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            
            // Live stream player
            if let player = player {
                CustomVideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onChange(of: vm.isMuted) { isMuted in
                        player.isMuted = isMuted
                    }
            } else {
                // show error view
            }
            
            FullscreenStreamOverlayView(chatMessage: $chatMessage)
        }
        .toolbar(.hidden)
        .onAppear() {
            guard let url = URL(string: streamUrl) else { return }
            player = AVPlayer(url: url)
            player?.play()
        }
        .onDisappear() {
            player?.pause()
        }
    }
}

struct StreamView_Previews: PreviewProvider {
    static var previews: some View {
        StreamView(streamUrl: "https://moctobpltc-i.akamaihd.net/hls/live/571329/eight/playlist.m3u8")
            .environmentObject(HomeVM())
    }
}

struct StreamView1: View {
    let player: AVPlayer
    
    @EnvironmentObject var vm: HomeVM
    
    @State private var chatMessage = ""
    
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            
            // Live stream player
            CustomVideoPlayer(player: player)
                .ignoresSafeArea()
                .onAppear{
                    player.isMuted = vm.isMuted
                }
                .onChange(of: vm.isMuted) { newValue in
                    player.isMuted = newValue
                }
                .onDisappear {
                    player.pause()
                }
            
            FullscreenStreamOverlayView(chatMessage: $chatMessage)
        }
        .toolbar(.hidden)
        .onChange(of: vm.isWatching) { isWatching in
            DispatchQueue.main.async {
                if isWatching {
                    player.play()
                } else {
                    player.pause()
                }
            }
        }
    }
}
