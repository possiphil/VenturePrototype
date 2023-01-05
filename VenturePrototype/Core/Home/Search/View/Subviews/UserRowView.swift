//
//  UserRowView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/venture-prototype.appspot.com/o/profileImages%2F\(user.username).jpg?alt=media&token=f6a2315d-36d5-4b7e-a7ca-024d91db83db"), content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }, placeholder: {
                Image(systemName: "person.fill")
                    .foregroundColor(Color("SecondaryAccentColor"))
                    .frame(width: 40, height: 40)
                    .background(Color("PrimaryAccentColor"))
            })
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.subheadline.bold())
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                // add fixed frame -> length to bio (and display only the first line if there are more
                Text(user.name)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(documentID: "Venture", id: "1234", name: "Philipp", birthday: Date.now, userBio: "This is a test bioπ"))
    }
}
