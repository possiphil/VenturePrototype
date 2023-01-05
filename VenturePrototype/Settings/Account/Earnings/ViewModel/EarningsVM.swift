//
//  EarningsVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import Firebase
import FirebaseFirestore
import SwiftUI

class EarningsVM: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var error: Swift.Error?
    
    @Published var earnings = 0
    
    init() {
        self.fetchEarnings()
    }
    
    func fetchEarnings() {
        guard let username = Auth.auth().currentUser?.displayName else { return publishError(FirebaseError.userNotFound) }
        
        db.collection("users").document(username)
            .getDocument { document, error in
                guard error != nil else { return self.publishError(FirebaseError.serverError) }
                
                guard let document = document else { return self.publishError(FirebaseError.serverError) }
                guard let data = document.data() else { return self.publishError(FirebaseError.serverError) }
                
                self.earnings = data["earnings"] as? Int ?? 0
            }
    }
    
    // MARK: Publish error
    func publishError(_ error: Error) {
        self.error = error
    }
}
