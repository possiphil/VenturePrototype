//
//  LiveStreamingView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import AVFoundation
import SwiftUI

//struct LiveStreamingView: UIViewControllerRepresentable {
//    typealias UIViewControllerType = AVCaptureSession
//
//    @Binding var isStreaming: Bool
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<LiveStreamView>) -> AVCaptureViewController {
//        let captureViewController = AVCaptureViewController()
//        captureViewController.delegate = context.coordinator
//        return captureViewController
//    }
//
//    func updateUIViewController(_ uiViewController: AVCaptureViewController, context: UIViewControllerRepresentableContext<LiveStreamView>) {
//        if isStreaming {
//            uiViewController.startStreaming()
//        } else {
//            uiViewController.stopStreaming()
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, AVCaptureViewControllerDelegate {
//        var parent: LiveStreamView
//
//        init(_ captureView: LiveStreamView) {
//            self.parent = captureView
//        }
//
//        func captureViewController(_ captureViewController: AVCaptureViewController, didFinishStreamingVideo videoData: Data) {
//            // Upload the streamed video data to the server as an M3U8 video
//            uploadVideo(data: videoData, uid: uid, url: "https://www.venture-live.net/live")
//        }
//    }
//}

