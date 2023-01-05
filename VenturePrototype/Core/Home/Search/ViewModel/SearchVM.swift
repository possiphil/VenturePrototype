//
//  SearchVM.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 05.01.23.
//

import Foundation

class SearchVM: ObservableObject {
    let service = UserService()
    
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let query = searchText.lowercased()
            
            return users.filter { $0.username.lowercased().contains(query) }
        }
    }
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
}
