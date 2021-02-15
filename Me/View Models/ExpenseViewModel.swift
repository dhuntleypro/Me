//
//  ExpenseViewModel.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase


class ExpenseViewModel: ObservableObject {
    @Published var expenses = [Expense]()
    
    
    @Published var expenses2 : [Expense] = []

    // Cart Data
  @Published var cartExpenses: [Cart] = []

    var name : String = ""
    var price : Double = 0.0
    var price2 : String = ""

    var description: String = ""
    var image: String = ""
    var images: String = ""
    var tags: [String] = [""]
    var brand : String = ""
    var category : String = ""
    var sku : String = ""
    var releaseDate : String = ""
    
    
    
//
//   var expense: [Expense] = []
//
//    var total: Double {
//        if expense.count > 0 {
//            return expense.reduce(0) { $0 + $1.price }
//        } else {
//            return 0.1
//        }
//    }
//
//
//
//
    
    
    
    init() {
        fetchExpenses()
    }
    
    
    
    
    
    func addToCart(expense: Expense) {
        
        // check if its added ....
        
        self.expenses[getIndex(expense: expense, isCartIndex: false)].isAdded = expense.isAdded
        
//        self.filtered[getIndex(expense: expense, isCartIndex: false)].isAdded = !expense.isAdded

        if expense.isAdded {
            
            // remove from list....
            self.cartExpenses.remove(at: getIndex(expense: expense, isCartIndex: true))

            return
        }
        // else adding
        self.cartExpenses.append(Cart(expense: expense, quantity: 1))
    }
    
    func getIndex(expense : Expense, isCartIndex : Bool) -> Int {
        let index = self.expenses.firstIndex { item1 -> Bool in
            return expense.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartExpenses.firstIndex { item1 -> Bool in
            return expense.id == item1.expense.id

        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    
    func calculatorTotalPrice() -> String {
        var price : Float = 0.1
        
        cartExpenses.forEach { expense in
            price += Float(expense.quantity) * Float(truncating: expense.expense.cost)
        }
        
        return getPrice(value : price)
    }
    
    func getPrice(value: Float) -> String {
        let format = NumberFormatter()
        
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func fetchExpenses() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_USERS.document(currentUid).collection("expenses")
        
        // observes any changes in firbase data
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                guard let fromId = messageData["fromId"] as? String else { return }
                
                COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.expenses.append(Expense(user: user, dictionary: messageData))
                    self.expenses.sort(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                 

                }
            }
        }
    }
    
    
    
    func createExpense() {
        // get current user
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        print("DEBUG1: currentUid -- \(currentUid) ")
        
        
        let currentExpenseRef = COLLECTION_ALL_USER_ITEMS.document(currentUid).collection("expenses").document()
        
        let expenseID = currentExpenseRef.documentID
        print("DEBUG2: expenseID -- \(expenseID) ")
        let currentUserExpenses = COLLECTION_USERS.document(currentUid).collection("expenses").document(expenseID)
        
        
        let data: [String: Any] = [ "name" : name,
                                    "price" : price,
                                    "price2" : price2,
                                    "description": description,
                                    "image": image,
                                    "tags": tags,
                                    "brand" : brand,
                                    "category" : category,
                                    "sku" : sku,
                                    "releaseDate" : releaseDate,
                                    
                                    "id" : expenseID,
                                    "fromId" : currentUid,
                                    "timestamp" : Timestamp(date: Date())
        ]
        print("DEBUG3: expenseID -- \(expenseID) ")

        // Add expense to User
        currentUserExpenses.setData(data)
        print("DEBUG4: expenseID is id -- \(expenseID) ")

        print("DEBUG5: currentUserExpenses -- \(currentUserExpenses) ")

        // Add expense to All Expenses
        currentExpenseRef.setData(data)
        print("DEBUG6: currentExpenseRef -- \(currentExpenseRef) ")

    }
    
    
    
    func createDemoExpense() {
        // get current user
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        print("DEBUG1: currentUid -- \(currentUid) ")
        
        
        let currentExpenseRef = COLLECTION_ALL_USER_ITEMS.document(currentUid).collection("expenses").document()
        
        let expenseID = currentExpenseRef.documentID
        print("DEBUG2: expenseID -- \(expenseID) ")
        let currentUserExpenses = COLLECTION_USERS.document(currentUid).collection("expenses").document(expenseID)
        
        
        
        let data: [String: Any] = [
            "name" : "Air Jordan 13 Retro 'Starfish'",
            "price" : 553.70,
            "price2" : "553.70",
            
            "description": "The Air Jordan 13 Retro ‘Starfish’ features a familiar color palette that recalls the ‘Shattered Backboard’ editions of the Air Jordan 1. The upper combines a white tumbled leather base with orange suede paneling and signature dimpled overlays in more white leather. Traditional branding elements include an embroidered Jumpman atop the tongue and the 13's holographic eye on the lateral ankle. A contrasting black finish is applied to the panther-paw outsole.",
            "image": "660244_01",
            "tags": ["2020", "Our Favorites", "Just Dropped" ],
            "brand" : "brand",
            "category" : "sneakers",
            "sku" : "001",
            "releaseDate" : "02/02/2021",
            
            "id" : expenseID,
            //no -  crash
            //  "id" : expenseID,
            "fromId" : currentUid,
            "timestamp" : Timestamp(date: Date())
        ]
        // Add expense to User
        currentUserExpenses.setData(data)
        
        // Add expense to All Expenses
        currentExpenseRef.setData(data)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func createDemoExpenseGroup() {
        // get current user
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        print("DEBUG1: currentUid -- \(currentUid) ")
        
        
        let currentExpenseRef = COLLECTION_ALL_USER_ITEMS.document(currentUid).collection("expenses").document()
        
        let expenseID = currentExpenseRef.documentID
        print("DEBUG2: expenseID -- \(expenseID) ")
        let currentUserExpenses = COLLECTION_USERS.document(currentUid).collection("expenses").document(expenseID)
        
        
        
        let data: [String: Any] = [
            "name" : "Air Jordan 13 Retro 'Starfish'",
            "price" : 553.70,
            "price2" : "553.70",
            "description": "The Air Jordan 13 Retro ‘Starfish’ features a familiar color palette that recalls the ‘Shattered Backboard’ editions of the Air Jordan 1. The upper combines a white tumbled leather base with orange suede paneling and signature dimpled overlays in more white leather. Traditional branding elements include an embroidered Jumpman atop the tongue and the 13's holographic eye on the lateral ankle. A contrasting black finish is applied to the panther-paw outsole.",
            "image": "660244_01",
            "tags": ["2020", "Our Favorites", "Just Dropped" ],
            "brand" : "brand",
            "category" : "sneakers",
            "sku" : "001",
            "releaseDate" : "02/02/2021",
            
            "id" : expenseID,
            //no -  crash
            //  "id" : expenseID,
            "fromId" : currentUid,
            "timestamp" : Timestamp(date: Date())
        ]
        
        
        
        
        
        let data1: [String: Any] = [
            "name" : "Air Jordan 1 Retro High OG 'Volt Gold'",
            "price" : 353.70,
            "price2" : "553.70",
            "description": "The Air Jordan 13 Retro ‘Starfish’ features a familiar color palette that recalls the ‘Shattered Backboard’ editions of the Air Jordan 1. The upper combines a white tumbled leather base with orange suede paneling and signature dimpled overlays in more white leather. Traditional branding elements include an embroidered Jumpman atop the tongue and the 13's holographic eye on the lateral ankle. A contrasting black finish is applied to the panther-paw outsole.",
            "image": "602213_01",
            "tags": ["2020", "Our Favorites", "Just Dropped" ],
            "brand" : "brand",
            "category" : "sneakers",
            "sku" : "001",
            "releaseDate" : "02/02/2021",
            
            "id" : expenseID,
            //no -  crash
            //  "id" : expenseID,
            "fromId" : currentUid,
            "timestamp" : Timestamp(date: Date())
        ]
         
        // Add expense to User
        currentUserExpenses.setData(data)
        
        // Add expense to All Expenses
        currentExpenseRef.setData(data)
        
        // Add expense to User
        currentUserExpenses.setData(data1)
        
        // Add expense to All Expenses
        currentExpenseRef.setData(data1)
        
    }
    
    
    
    
    
    
   
    
    func updateExpense(
        p_ID : String,
        name : String,
        price : Double,
        price2 : String,
        description : String,
        image : String,
        tags : [String],
        brand  : String,
        category  : String,
        sku  : String,
        releaseDate  : String
    ) {
        
        
        // get current user
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        print("DEBUG01: currentUid -- \(currentUid) ")
        
        let expenseDictionary = [
            
            "name" : name,
            "price" : price,
            "price2" : price2,
            "description": description,
            "image": image,
            "tags": tags,
            "brand" : brand,
            "category" : category,
            "sku" : sku,
            "releaseDate" : releaseDate,
            
            "id" : p_ID,
            "fromId" : currentUid,
            "timestamp" : Timestamp(date: Date())
            
        ] as [String : Any]
        
        print("DEBUG03: expenseID -- \(p_ID) ")
        
        
        print("DEBUG04: expenseDictionary -- \(expenseDictionary) ")
        print("setting data")
        
        
        
        let currentUserExpense = COLLECTION_USERS.document(currentUid).collection("expenses").document(p_ID)
        
        
        // update / not create ( not working yest)
        currentUserExpense.setData(expenseDictionary, merge: true) { error in
            if let error = error {
                print("error = \(error)")
            } else {
                print("data updated sucessfully to all user expenses")
                
            }
        }
    }
    
}
