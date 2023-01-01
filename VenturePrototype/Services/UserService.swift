//
//  UserService.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 28.12.22.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    func fetchUser(withDisplayName displayName: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(displayName)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: Error fetching user \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
}
