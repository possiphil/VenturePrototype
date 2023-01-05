//
//  BugReportVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import Firebase
import FirebaseFirestoreSwift

final class BugReportVM: ObservableObject {
    @Published var error: Swift.Error?
    
    @Published var problem = "" {
        didSet {
            if problem.count > 30 {
                problem = String(problem.prefix(30))
            }
        }
    }
    @Published var description = "" {
        didSet {
            if description.count > 1000 {
                problem = String(problem.prefix(1000))
            }
        }
    }
    
    func reportDetailsMissing() -> Bool {
        return problem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func reportProblem(completion: @escaping() -> Void) {
        guard let user = Auth.auth().currentUser?.displayName else { return publishError(FirebaseError.userNotFound) }
        
        let data = [
            "problem": problem,
            "description": description,
            "user": user,
            "time": Timestamp(date: Date.now)
        ] as [String: Any]
        
        Firestore.firestore().collection("reports").document()
            .setData(data) { error in
                if error != nil {
                    self.publishError(FirebaseError.serverError)
                    return
                }
                
                completion()
            }
    }
    
    func publishError(_ error: Error) {
        self.error = error
    }
}
