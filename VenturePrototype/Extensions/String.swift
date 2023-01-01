//
//  String.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 31.12.22.
//

import Foundation

extension String {
  func removeEmojis() -> String {
    return String(self.filter { !$0.isEmoji() })
  }
}

extension Character {
  fileprivate func isEmoji() -> Bool {
    return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
      || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
  }
}
