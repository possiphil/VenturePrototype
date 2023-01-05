//
//  FullscreenStreamOverlayView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import SwiftUI

struct FullscreenStreamOverlayView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: HomeVM
    
    @Binding var chatMessage: String
    
    var body: some View {
        VStack(spacing: 8) {
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
                
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding()
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.horizontal, 12)
            
            Spacer()
            
            HStack(spacing: 4) {
                Spacer()
                
                Text("•")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                    .offset(y: -2)
                
                Text("320")
                    .foregroundColor(.red)
            }
            .padding(.horizontal)
            
            HStack(spacing: 16) {
                TextField("", text: $chatMessage)
                    .placeholder("Send a message", when: chatMessage.isEmpty)
                    .autocorrectionDisabled()
                    .foregroundColor(.white)
                    .frame(height: 44)
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 2)
                            .fill(Color.white)
                    }
                
                Image(systemName: "crown.fill")
                    .font(.title)
                    .foregroundColor(Color("PrimaryAccentColor"))
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }

    }
}

struct FullscreenStreamOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenStreamOverlayView(chatMessage: .constant(""))
    }
}
