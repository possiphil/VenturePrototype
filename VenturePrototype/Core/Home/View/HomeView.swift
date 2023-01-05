//
//  HomeView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//
// MARK: Improvement - Implement if statement to show StreamView when user taps on stream and add custom transition

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeVM()
    
    @Namespace var animation
    
    var body: some View {
        NavigationStack {
            ZStack {
                if vm.selectedCategory == .trending {
                    TrendingView()
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                        .environmentObject(vm)
                } else if vm.selectedCategory == .following {
                    FollowingView()
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut)
                        .zIndex(1)
                        .environmentObject(vm)
                }
                
                VStack {
                    ZStack {
                        HStack {
                            Image(systemName: vm.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .offset(y: -5)
                                .background(.black.opacity(0.01))
                                .onTapGesture {
                                    vm.isMuted.toggle()
                                }
                            
                            Spacer()
                            
                            NavigationLink {
                                SearchView()
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .offset(y: -5)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 24) {
                            ForEach(StreamCategories.allCases, id: \.self) { category in
                                ZStack {
                                    Color.black.opacity(0.01)
                                    
                                    VStack(spacing: 8) {
                                        Text(category.title)
                                            .font(.subheadline)
                                            .fontWeight(vm.selectedCategory == category ? .semibold : .regular)
                                            .foregroundColor(.white)
                                            .opacity(vm.selectedCategory == category ? 1 : 0.5)
                                        
                                        if vm.selectedCategory == category {
                                            Capsule()
                                                .foregroundColor(.white)
                                                .matchedGeometryEffect(id: "category", in: animation)
                                                .frame(width: 20 , height: 3)
                                                .animation(.easeInOut)
                                        } else {
                                            Capsule()
                                                .foregroundColor(Color(.clear))
                                                .frame(height: 3)
                                        }
                                    }
                                }
                                .frame(height: 44)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        vm.selectedCategory = category
                                    }
                                }
                            }
                        }
                        .fixedSize()
                    }
                    
                    Spacer()
                }
                .zIndex(2)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabView()
    }
}

struct HomeView1: View {
    @StateObject private var vm = HomeVM()
    
    @Namespace var animation
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.selectedCategory == .trending {
                    Text("TrendingView")
                        .environmentObject(vm)
                } else if vm.selectedCategory == .following {
                    FollowingView()
                        .environmentObject(vm)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                SearchView()
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding()
                                    .offset(y: -5)
                            }
                        }
                        
                        HStack(spacing: 24) {
                            ForEach(StreamCategories.allCases, id: \.self) { category in
                                ZStack {
                                    Color.black.opacity(0.01)
                                    
                                    VStack(spacing: 8) {
                                        Text(category.title)
                                            .font(.subheadline)
                                            .fontWeight(vm.selectedCategory == category ? .semibold : .regular)
                                            .foregroundColor(.white)
                                            .opacity(vm.selectedCategory == category ? 1 : 0.5)
                                        
                                        if vm.selectedCategory == category {
                                            Capsule()
                                                .foregroundColor(.white)
                                                .frame(width: 20 , height: 3)
                                                .matchedGeometryEffect(id: "category", in: animation)
                                        } else {
                                            Capsule()
                                                .foregroundColor(Color(.clear))
                                                .frame(height: 3)
                                        }
                                    }
                                }
                                .frame(height: 44)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        vm.selectedCategory = category
                                    }
                                }
                            }
                        }
                        .fixedSize()
                    }
                    
                    Spacer()
                }
                .padding()
        }
        }
    }
}
