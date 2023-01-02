//
//  EditProfileView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct EditProfileView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var bio = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .frame(width: 160, height: 160)
                
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .background(.white)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(4)
            }
            
            Form {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 26) {
                        Text("Name")
                        Text("Username")
                        Text("Bio")
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        TextField("Your name", text: $name)
                        Divider()
                        TextField("Your name", text: $username)
                        Divider()
                        TextField("Bio", text: $bio, axis: .vertical)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5...5)
                    }
                    
                }
            }
            .formStyle(.columns)
            .padding()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
