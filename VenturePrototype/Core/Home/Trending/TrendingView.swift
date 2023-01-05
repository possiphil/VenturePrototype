//
//  TrendingView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//
// https://www.youtube.com/watch?v=Myl21dnEQ40
// MARK: Refresh when dragged down on first stream
// MARK: Jump to next item when stream ends
// MARK: Is default volume too loud?
//
// TODO: Save which stream was viewed when changing view and open this one when coming back and its still live

import AVKit
import SwiftUI

struct TrendingView: View {
    @EnvironmentObject var vm: HomeVM
    
    @State private var selectedCategory: StreamCategories = .trending
    @State private var currentStream = ""
    
    @State private var streams = [
        Stream(player: AVPlayer(url: URL(string: "https://moctobpltc-i.akamaihd.net/hls/live/571329/eight/playlist.m3u8")!)),
        Stream(player: AVPlayer(url: URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8")!))
    ]
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            TabView(selection: $currentStream) {
                ForEach($streams) { $stream in
                    ZStack {
                        StreamPlayer(stream: $stream, currentStream: $currentStream)
                            .environmentObject(vm)
                        
                        StreamOverlayView()
                    }
                    .frame(width: size.width)
                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                    .tag(stream.id)
                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .padding(.bottom, 4)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentStream = streams.first?.id ?? ""
            vm.startStream()
        }
        .onDisappear {
            vm.stopStream()
        }
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabView()
    }
}

struct StreamPlayer: View {
    @EnvironmentObject var vm: HomeVM
    
    @Binding var stream: Stream
    @Binding var currentStream: String
    
    var body: some View {
        ZStack {
            if let player = stream.player {
                CustomVideoPlayer(player: player)
                    .onAppear{
                        player.isMuted = vm.isMuted
                    }
                    .onChange(of: vm.isMuted) { isMuted in
                        player.isMuted = isMuted
                    }
                
                // Playing stream based on offset
                GeometryReader { proxy -> Color in
                    let size = proxy.size
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentStream == stream.id && vm.isWatching {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                    
                    return Color.clear
                }
                
            } else {
                // show error screen
            }
        }
    }
}


//struct VideoPlayerView: View {
//    @Binding var stream: Stream
//    @Binding var currentStream: String
//
//    @State private var isMuted = false
//    @State private var isVolumeAnimated = false
//
//    var body: some View {
//        if let player = stream.player {
//            VideoPlayer(player: player) {
//                ZStack {
//                    GeometryReader { proxy -> Color in
//                        let size = proxy.size
//                        let minY = proxy.frame(in: .global).minY
//
//                        DispatchQueue.main.async {
//                            if -minY < (size.height / 2) && minY < (size.height / 2) && currentStream == stream.id {
//                                player.play()
//                            } else {
//                                player.pause()
//                            }
//                        }
//
//                        return Color.clear
//                    }
//
//                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(.tertiary)
//                        .clipShape(Circle())
//                        .foregroundStyle(.black)
//                        .opacity(isVolumeAnimated ? 1 : 0)
//                }
//            }
//            .frame(width: 320, height: 320, alignment: .center)
//            .onTapGesture {
//                if isVolumeAnimated {
//                    return
//                }
//
//                isMuted.toggle()
//                player.isMuted = isMuted
//                withAnimation{ isVolumeAnimated.toggle() }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    withAnimation{ isVolumeAnimated.toggle() }
//                }
//            }
//        } else {
//            // show error screen
//        }
//    }
//
//}
//
//struct TrendingView1: View {
//    @StateObject var vm = HomeVM()
////    @EnvironmentObject var vm: HomeVM
//
//    @Namespace var animation
//
//    @State private var selectedCategory: StreamCategories = .trending
//    @State private var currentStream = ""
//
//    @State private var streams = [
//        Stream(player: AVPlayer(url: URL(string: "https://moctobpltc-i.akamaihd.net/hls/live/571329/eight/playlist.m3u8")!)),
//        Stream(player: AVPlayer(url: URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8")!))
//    ]
//
//    var body: some View {
//        NavigationStack {
//            GeometryReader { proxy in
//                let size = proxy.size
//
//                TabView(selection: $currentStream) {
//                    ForEach($streams) { $stream in
//                        StreamPlayer(stream: $stream, currentStream: $currentStream)
//                            .frame(width: size.width)
//                            .rotationEffect(.init(degrees: -90))
//                            .ignoresSafeArea(.all, edges: .top)
//                            .tag(stream.id)
//                            .environmentObject(vm)
//                    }
//                }
//                .rotationEffect(.init(degrees: 90))
//                .frame(width: size.height)
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                .frame(width: size.width)
//
//            }
//            .toolbar(.hidden)
//            .ignoresSafeArea(.all, edges: .top)
//            .padding(.bottom, 4)
//            .background(Color.black.ignoresSafeArea())
//            .overlay {
//                VStack {
//                    ZStack {
//                        HStack {
//                            Spacer()
//
//                            NavigationLink {
//                                SearchView()
//                            } label: {
//                                Image(systemName: "magnifyingglass")
//                                    .font(.title3)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .offset(y: -5)
//                            }
//                        }
//
//                        HStack(spacing: 24) {
//                            ForEach(StreamCategories.allCases, id: \.self) { category in
//                                ZStack {
//                                    Color.black.opacity(0.01)
//
//                                    VStack(spacing: 8) {
//                                        Text(category.title)
//                                            .font(.subheadline)
//                                            .fontWeight(vm.selectedCategory == category ? .semibold : .regular)
//                                            .foregroundColor(.white)
//                                            .opacity(vm.selectedCategory == category ? 1 : 0.5)
//
//                                        if vm.selectedCategory == category {
//                                            Capsule()
//                                                .foregroundColor(.white)
//                                                .frame(width: 20 , height: 3)
//                                                .matchedGeometryEffect(id: "category", in: animation)
//                                        } else {
//                                            Capsule()
//                                                .foregroundColor(Color(.clear))
//                                                .frame(height: 3)
//                                        }
//                                    }
//                                }
//                                .frame(height: 44)
//                                .onTapGesture {
//                                    withAnimation(.easeInOut) {
//                                        vm.selectedCategory = category
//                                    }
//                                }
//                            }
//                        }
//                        .fixedSize()
//                    }
//
//                    Spacer()
//                }
//                .padding()
//            }
//            .onAppear {
//                currentStream = streams.first?.id ?? ""
//                vm.startStream()
//            }
//            .onDisappear {
//                vm.stopStream()
//            }
//        }
//    }
//}
//
//struct StreamPlayer1: View {
//    @EnvironmentObject var vm: HomeVM
//
//    @Binding var stream: Stream
//    @Binding var currentStream: String
//
//    @State private var isMuted = false
//    @State private var isVolumeAnimated = false
//
//    var body: some View {
//        ZStack {
//            if let player = stream.player {
//                CustomVideoPlayer(player: player)
//                // Volume Control
//                    .onTapGesture {
//                        if isVolumeAnimated {
//                            return
//                        }
//
//                        isMuted.toggle()
//                        player.isMuted = isMuted
//                        withAnimation{ isVolumeAnimated.toggle() }
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            withAnimation{ isVolumeAnimated.toggle() }
//                        }
//                    }
//                    .onChange(of: vm.isWatching) { newValue in
//                        print(vm.isWatching)
//                        player.pause()
//                        if newValue == false {
//                            player.pause()
//                        }
//                    }
//
//                // Playing stream based on offset
//                GeometryReader { proxy -> Color in
//                    let size = proxy.size
//                    let minY = proxy.frame(in: .global).minY
//
//                    DispatchQueue.main.async {
//                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentStream == stream.id && vm.isWatching {
//                            player.play()
//                        } else {
//                            player.pause()
//                        }
//                    }
//
//                    return Color.clear
//                }
//
//                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(.tertiary)
//                    .clipShape(Circle())
//                    .foregroundStyle(.black)
//                    .opacity(isVolumeAnimated ? 1 : 0)
//
//            } else {
//                // show error screen
//                LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
//            }
//        }
//    }
//}
//
