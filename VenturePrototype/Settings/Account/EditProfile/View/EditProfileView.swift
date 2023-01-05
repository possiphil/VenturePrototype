//
//  EditProfileView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var username = ""
    @State private var bio = ""
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
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
                
                Button("Remove Profile Picture") {}
                    .font(.subheadline)
            }
            
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Name")
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                        .lineLimit(1)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .fill()
                        }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Username")
                    TextField("Username", text: $username)
                        .autocorrectionDisabled()
                        .lineLimit(1)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .fill()
                        }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bio")
                    TextField("Bio", text: $bio, axis: .vertical)
                        .autocorrectionDisabled()
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .fill()
                        }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.vertical)
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") { saveChanges() }
            }
        }
    }
    
    func saveChanges() {
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditProfileView()
        }
    }
}
