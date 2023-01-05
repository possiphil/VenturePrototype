//
//  User.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var documentID: String?
    let id: String
    let name: String
    let birthday: Date
    let userBio: String?
    
    var username: String {
        documentID ?? ""
    }
    
    var bio: String {
        userBio ?? ""
    }
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
    static let example = User(documentID: "Venture", id: "1234", name: "Philipp", birthday: Date.now, userBio: "This is an example user bio.")
}
