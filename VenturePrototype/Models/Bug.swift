//
//  Bug.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import Firebase
import FirebaseFirestoreSwift

struct Bug: Codable {
    @DocumentID var timestamp: String?
    let username: String
    let title: String
    let caption: String
}
