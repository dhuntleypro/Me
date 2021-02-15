//
//  OrderBasket.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

//import Foundation
//import Firebase
//
//class OrderBasketViewModel: Identifiable {
//    
//    @Published var orders = [OrderBasket]()
//
//    
//    
//    var id: String!
//    var ownerId: String!
//    var items: [Expense] = []
//    
//    var total: Double {
//        if items.count > 0 {
//            return items.reduce(0) { $0 + $1.price }
//        } else {
//            return 0.0
//        }
//    }
//    
//    init () {
//        fetchOrders()
//    }
//    
//    
//    func fetchOrders() {
//        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
//        
//        let query = COLLECTION_USERS.document(currentUid).collection("orders")
//        
//        // observes any changes in firbase data
//        query.addSnapshotListener { snapshot, _ in
//            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
//            
//            changes.forEach { change in
//                let messageData = change.document.data()
//                guard let fromId = messageData["fromId"] as? String else { return }
//                
//                COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
//                    guard let data = snapshot?.data() else { return }
//                    let user = User(dictionary: data)
//                    self.orders.append(OrderBasket(user: user, dictionary: messageData))
//                    self.orders.sort(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
//                    
////                   // self.expense.reduce(0) { $0 + $1.price }
////
////                    var total: Double {
////                        if self.expense.count > 0 {
////                            return self.expense.reduce(0) { $0 + $1.price }
////                        } else {
////                            return 0.1
////                        }
////                    }
////                    print("DEBUG : TOTAL -- \(total)")
//
//                }
//               // return total
//
//            }
//        }
//    }
//    
//    func add(_ item: Expense) {
//        items.append(item)
//    }
//    
//    
//    func emptyBasket() {
//        self.items = []
//    }
//    
//  
//    
//
//
//
//}
