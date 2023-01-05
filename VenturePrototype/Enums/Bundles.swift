//
//  Bundles.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

enum Bundles: CaseIterable {
    case two
    case five
    case ten
    case twenty
    case fifty
    case hundred
    case threeHundred
    
    var price: Double {
        switch self {
            case .two:          return 1.99
            case .five:         return 4.99
            case .ten:          return 9.99
            case .twenty:       return 19.99
            case .fifty:        return 49.99
            case .hundred:      return 99.99
            case .threeHundred: return 299.99
        }
    }
    
    var crownAmount: Int {
        switch self {
            case .two:          return 80
            case .five:         return 205
            case .ten:          return 420
            case .twenty:       return 860
            case .fifty:        return 2200
            case .hundred:      return 4500
            case .threeHundred: return 14200
        }
    }
    
    var extraCrowns: Int? {
        switch self {
            case .two:          return nil
            case .five:         return 5
            case .ten:          return 20
            case .twenty:       return 60
            case .fifty:        return 200
            case .hundred:      return 500
            case .threeHundred: return 2200
        }
    }
    
    var crownImage: String {
        switch self {
            case .two:          return "crown_bronze"
            case .five:         return "crown_bronze"
            case .ten:          return "crown_silver"
            case .twenty:       return "crown_silver"
            case .fifty:        return "crown_gold"
            case .hundred:      return "crown_gold"
            case .threeHundred: return "crown_platinum"
        }
    }
}
