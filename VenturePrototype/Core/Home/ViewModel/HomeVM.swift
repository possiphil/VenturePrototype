//
//  HomeVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var selectedCategory: StreamCategories = .trending
    
    @Published var currentStream = ""
    @Published var isWatching = true
    @Published var isMuted = true
    @Published var showFullscreenStream = false
    
    func startStream() {
        isWatching = true
    }
    
    func stopStream() {
        isWatching = false
    }
}
