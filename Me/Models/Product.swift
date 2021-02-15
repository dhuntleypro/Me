//
//  Expense.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase

struct Expense : Identifiable {
    let name : String
    let price : Double
    let price2 : String
    let description : String
    var tags: [String]
    let brand : String
    let image : String
    let images : [String]
    let category : String
    let sku : String
    let releaseDate : String

    let user : User
    
    let toId : String
    let fromId : String
    let isFromCurrentUser : Bool
    let timestamp: Timestamp
    let id: String
    
    var chatPartnerId:  String { return isFromCurrentUser ? toId : fromId }
    
    init(user: User, dictionary: [String : Any]) {
        self.user = user
        
        self.name = dictionary["name"] as? String ?? ""
        self.price = dictionary["price"] as? Double ?? 0.0
        self.price2 = dictionary["price2"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.tags = dictionary["tags"] as? [String] ?? [""]
        self.brand = dictionary["brand"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.sku = dictionary["sku"] as? String ?? ""
        self.releaseDate = dictionary["releaseDate"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.images = dictionary["images"] as? [String] ?? [""]
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
    }
}


