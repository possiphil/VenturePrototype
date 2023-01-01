//
//  User.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var username: String?
    let id: String
    let name: String
    let birthday: Date
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
}
