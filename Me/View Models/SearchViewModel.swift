//
//  SearchViewModel.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    // MODEL
    @Published var users = [User]()
    
    init() {
        fetchUser()
    }
    
    // (fix) change to expenses
    func fetchUser() {
//        Firestore.firestore()
//            .collection("users")
        COLLECTION_USERS
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            // CREATE A USER FOR EACH DOCUMENT
            self.users = documents.map({ User(dictionary: $0.data()) })
            
            
        }
    }
    
    func filterUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
}
