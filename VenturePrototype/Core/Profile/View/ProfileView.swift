//
//  ProfileView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct ProfileView: View {
    let user: User
    let url: URL?
    
    @StateObject var vm = ProfileVM()
    
    @Namespace var animation
    
    @State private var selectedFilter = ProfileFilter.following
    
    let columns = [GridItem(.adaptive(minimum: 80, maximum: 80))]
    
    init(user: User) {
        self.user = user
        self.url = URL(string: "https://firebasestorage.googleapis.com/v0/b/venture-prototype.appspot.com/o/profileImages%2F\(user.username).jpg?alt=media&token=f6a2315d-36d5-4b7e-a7ca-024d91db83db")
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("profileBackground7")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.all, edges: .top)
            
            GeometryReader { proxy in
                VStack {
                    Spacer()
                        .frame(height: proxy.size.height * 0.2)
                    
                    VStack(spacing: 32) {
                        VStack {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 128, height: 128)
                            } placeholder: {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 48))
                                    .foregroundColor(Color("SecondaryAccentColor"))
                                    .frame(width: 128, height: 128)
                                    .background(Color("PrimaryAccentColor"))
                            }
                            .overlay {
                                Circle()
                                    .stroke(lineWidth: 16)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(.gray), .black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                            .clipShape(Circle())
                            
                            HStack(spacing: 12) {
                                Text(user.username)
                                    .font(.title2)
                                    .padding(.bottom, 8)
                                
                                Button {
                                    // follow user
                                } label: {
                                    Text("Follow")
                                        .bold()
                                        .foregroundColor(.primary)
                                        .frame(width: 88, height: 44)
                                        .background(Color("PrimaryAccentColor"))
                                        .cornerRadius(12)
                                }
                                .offset(x: 12, y: -2)
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(user.name)
                                    .font(.headline)
                                
                                Text(user.bio)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        }
                        .offset(y: -64)
                        
                        VStack(spacing: 0) {
                            HStack {
                                ForEach(ProfileFilter.allCases, id: \.rawValue) { filter in
                                    VStack {
                                        VStack {
                                            Text(filter.amount)
                                                .font(.title2)
                                            Text(filter.title)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        if selectedFilter == filter {
                                            Capsule()
                                                .foregroundColor(Color("PrimaryAccentColor"))
                                                .frame(height: 3)
                                                .matchedGeometryEffect(id: "filter", in: animation)
                                                .animation(.easeInOut(duration: 0.5))
                                        } else {
                                            Capsule()
                                                .foregroundColor(Color(.clear))
                                                .frame(height: 3)
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            self.selectedFilter = filter
                                        }
                                    }
                                }
                            }
                            .overlay(Divider().offset(x: 0, y: 28))
                            
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(0..<100) { _ in
                                        VStack(spacing: 4) {
                                            Circle()
                                                .frame(width: 48, height: 48)
                                            
                                            Text("Possiphil")
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        .padding(.top, -64)
                    }
                    .padding(.bottom, 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("ReversePrimary"), in: RoundedShape(corners: [.topRight, .topLeft]))
                }
            }
        }
    }
    
    func getLocalImage() -> Image? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appending(path: "profileImage.jpg")
        if let data = try? Data(contentsOf: url), let loaded = UIImage(data: data) {
            return Image(uiImage: loaded)
        } else {
            return nil
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(documentID: "Venture", id: "1234", name: "Philipp", birthday: Date.now, userBio: "This is a test bio."))
    }
}

