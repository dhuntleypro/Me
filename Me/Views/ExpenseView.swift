//
//  ExpenseView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct ExpenseView: View {
    @ObservedObject var expenseVM = ExpenseViewModel()

    @Binding var isShowingCreateNewExpenseView : Bool
    @State private var showingBasket = false

  // var expense : Expense
    
    var expense: [Expense] = []

    
//    var totalPrice: Double {
//
//        let total = expenseVM.fetchExpenses
//     //   let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
//        return total // + tipValue
//    }
//
    
    
    var body: some View {

        
        VStack{
            
            HStack {
                
                VStack(alignment: .leading)  {
                    
                    Text("Expenses")
                        .font(.title)
                        .bold()
                    
//                    Text("Monthly Expense Total : \(totalPrice)")
//                        .font(.system(size: 13))
                }
                
                Spacer()
                
                Button(action: {
                   // print("DEBUG -- \(expenseVM.total)")

                    self.isShowingCreateNewExpenseView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill").font(.system(size: 36, weight: .regular)).foregroundColor(Color(.black))
                }
                .fullScreenCover(isPresented: $isShowingCreateNewExpenseView) {
                    AddNewExpenseView()
                }
            }
            .padding()

            
            Divider()
 
            ScrollView(.vertical) {
                
                VStack {
                    
                    ForEach(expenseVM.expenses) { expense in
                        
                        // List of expenses
                        NavigationLink(destination: ExpenseEditView(
                            
                            
                            
                            expense: expense,
                            user: expense.user,
                            expenseID: expense.id,
                            name: expense.name,
                            price: expense.price,
                            price2: expense.price2,
                            description: expense.description,
                            image: expense.image,
                            images: expense.image,
                            tags: expense.tags,
                            brand: expense.brand,
                            category: expense.category,
                            sku: expense.sku,
                            releaseDate: expense.releaseDate
                            
                            
                            
                        )) {
                            ExpenseCell(expense: expense)
                            
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    self.showingBasket.toggle()
                }, label: {
                    Text("Active")
                })
                    .sheet(isPresented: $showingBasket) {
                    //    OrderBasketView()

                }
        )

    }

}


