//
//  ProfileFilter.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import Foundation

enum ProfileFilter: Int, CaseIterable {
    case following
    case followers
    
    var title: String {
        switch self {
        case .following: return "Following"
        case .followers: return "Followers"
        }
    }
    
    var amount: String {
        switch self {
        case .following: return "704"
        case .followers: return "4.5M"
        }
    }
}
