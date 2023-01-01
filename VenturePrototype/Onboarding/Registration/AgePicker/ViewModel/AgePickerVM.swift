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
    @Published var error: Swift.Error?
    
    // MARK: Convert birthday String to Date
    func convertBirthdayStringToDate(birthDay: String, birthMonth: String, birthYear: String, completion: @escaping(Date) -> Void) {
        let string = birthDay + "/" + birthMonth + "/" + birthYear
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let date = dateFormatter.date(from: string) else {
            publishError(UserError.invalidBirthdate)
            return
        }
        
        let age = Date().timeIntervalSince(date) / 60 / 60 / 24 / 365
        #warning("Check age restriction when shipping and change accordingly.")
        if age > 125.0 || age <= 0.0{
            publishError(UserError.invalidBirthdate)
        } else if age < 13.0  {
            publishError(UserError.tooYoung)
        } else {
            completion(date)
        }
    }
    
    func publishError(_ error: UserError) {
        self.error = error
    }
}
