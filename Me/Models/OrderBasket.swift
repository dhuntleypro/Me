//
//  OB.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//


import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    
    var id: String!
    var ownerId: String!
    var items: [Expense] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0.0
        }
    }




}
