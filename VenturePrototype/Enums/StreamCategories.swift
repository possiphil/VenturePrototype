//
//  StreamCategories.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import Foundation

enum StreamCategories: CaseIterable {
    case following
    case trending
    
    var title: String {
        switch self {
        case .following: return "Following"
        case .trending: return "Trending"
        }
    }
}
