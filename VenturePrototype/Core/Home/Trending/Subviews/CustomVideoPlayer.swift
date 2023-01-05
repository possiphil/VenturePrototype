//
//  CustomVideoPlayer.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = false
        
        controller.videoGravity = .resizeAspectFill
        
        // is this needed or better to leave out?
        player.actionAtItemEnd = .pause
        player.preventsDisplaySleepDuringVideoPlayback = true
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }
}
