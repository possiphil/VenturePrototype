//
//  ProfileVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import Firebase
import Foundation

class ProfileVM: ObservableObject {
    let collection = Firestore.firestore().collection("users")
    
    @Published var isFollowing = false
    @Published var following = [User]()
    @Published var followers = [User]()
    
    init() {
    }
    
    func isFollowing(_ user: User) {
        collection.document(user.username).collection("followers")
            .getDocuments { snapshot, error in
                if error != nil { return print("DEBUG: Error fetching documents") }
                
                guard let documents = snapshot?.documents else { return }
                guard let currentUserDisplayName = Auth.auth().currentUser?.displayName else { return }
                
                for document in documents {
                    if document.documentID == currentUserDisplayName {
                        self.isFollowing = true
                    } else {
                        self.isFollowing = false
                    }
                }
            }
    }
}
