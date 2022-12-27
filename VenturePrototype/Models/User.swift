//
//  User.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: String
    let name: String
    let birthday: Date
    let username: String
    let imageUrl: String?
}
