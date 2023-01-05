//
//  StreamOverlayView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import SwiftUI

struct StreamOverlayView: View {
    var body: some View {
        HStack {
            VStack(spacing: 8) {
                Spacer()
                
                Text("Improving Venture, do you have any suggestions?")
                    .font(.callout)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 16) {
                    NavigationLink {
                        ProfileView(user: User.example)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "person.fill")
                                .font(.subheadline)
                                .foregroundColor(Color("SecondaryAccentColor"))
                                .frame(width: 32, height: 32)
                                .background(Color("PrimaryAccentColor"))
                                .clipShape(Circle())
                            
                            Text("Venture")
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                    Button {
                        // Follow user and switch button to Followed button
                    } label: {
                        Text("Follow")
                            .font(.footnote.bold())
                            .foregroundColor(Color("PrimaryAccentColor"))
                            .frame(width: 72, height: 28)
                            .background(.white.opacity(0.1))
                            .cornerRadius(8)
                            .shadow(radius: 1)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .fill(.white)
                            }
                            .padding(.vertical, 8)
                    }
                    
                    
                    Spacer()
                    
                    
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "crown.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        // Show dare menu (maybe sheet or confirmation dialog)
                    }
                
                Image(systemName: "ellipsis.bubble.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        // Show textfield for user to write something
                    }
                
                HStack(spacing: 2) {
                    Text("•")
                        .font(.title)
                        .bold()
                        .foregroundColor(.red)
                        .offset(y: -2)
                    
                    Text("320")
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 4)
        }
        .padding(.bottom, 12)
    }
}

struct StreamOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StreamOverlayView()
                .background(.blue)
        }
    }
}
