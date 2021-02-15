//
//  OrderBasketView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//
//
//
//import SwiftUI
//
//struct OrderBasketView: View {
//    
//    @ObservedObject var expenseVM = ExpenseViewModel()
//
//    var body: some View {
//        
//        NavigationView {
//            
//            List {
//                Section {
//                    ForEach(self.expenseVM.orderBasket?.items ?? []) { expense in
//                        HStack {
//                            Text(expense.name)
//                            Spacer()
//                            Text("$\(expense.price.clean)")
//                        }//End of HStack
//                    }//End of ForEach
////                        .onDelete { (indexSet) in
////                            self.deleteItems(at: indexSet)
////                    }
//                }
//                
//                Section {
//                    NavigationLink(destination: CheckoutView()) {
//                        Text("Place Order")
//                    }
//                }
//                .disabled(self.expenseVM.orderBasket?.items.isEmpty ?? true)
//                
//            } //End of List
//            .navigationBarTitle("Order")
//            .listStyle(GroupedListStyle())
//            
//            
//        } //End of Navigation view
//        
//    }
//    
////    func deleteItems(at offsets: IndexSet) {
////        self.basketListener.orderBasket.items.remove(at: offsets.first!)
////        self.basketListener.orderBasket.saveBasketToFirestore()
////    }
//    
//    
//}
//
//struct OrderBasketView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderBasketView()
//    }
//}
