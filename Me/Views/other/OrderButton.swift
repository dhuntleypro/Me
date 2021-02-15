//
//  OrderButton.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//
//
//import SwiftUI
//
//
//struct OrderButton : View {
//    
//    @ObservedObject var expenseVM = ExpenseViewModel()
//    
//    @Binding  var showingAlert : Bool
//
//    var expense: Expense
//    
//    var body : some View {
//        
//        Button(action: {
//            
//        //    self.addItemToBasket()
//
//           print("does nothing")
//        }) {
//            Text("Add to basket")
//        }
//        .frame(width: 200, height: 50)
//        .foregroundColor(.white)
//        .font(.headline)
//        .background(Color.blue)
//        .cornerRadius(10)
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Added to Basket!"), dismissButton: .default(Text("OK")))
//    }
//    
//        
//    }
//    
////    private func addItemToBasket() {
////        
////        var orderBasket: OrderBasketViewModel!
////
////        if self.expenseVM.orderBasket != nil {
////            
////           // orderBasket = self.expenseVM.orderBasket
////        } else {
////            print("ffffffff")
////            orderBasket = OrderBasketViewModel()
////          //  orderBasket.ownerId = FUser.currentId()
////            orderBasket.id = UUID().uuidString
////        }
////        
////        orderBasket.add(self.expense)
////     //   orderBasket.saveBasketToFirestore()
////    }
//    
//}
