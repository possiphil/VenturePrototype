//
//  AgePickerVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import Foundation

enum Focus {
    case day
    case month
    case year
}

class AgePickerVM: ObservableObject {
    @Published var focusedTextField: Focus?
    
    @Published var birthDay = ""
    @Published var birthMonth = ""
    @Published var birthYear = ""
    
    func dateInformationMissing() -> Bool {
        return birthDay.isEmpty || birthMonth.isEmpty || birthYear.isEmpty
    }
}
