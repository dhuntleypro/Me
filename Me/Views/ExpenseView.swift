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

    
    var body: some View {

        
        
        VStack {
            
            
            
            HStack {
                Text("Expenses")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    self.isShowingCreateNewExpenseView.toggle()
                }) {
                    Text("+")
                }
                .fullScreenCover(isPresented: $isShowingCreateNewExpenseView) {
                    AddNewExpenseView()
                }
            }
            .padding()
            
            
            
            ScrollView(.horizontal) {
                
                HStack(spacing: 35) {
                    
                    ForEach(expenseVM.expenses) { expense in
                        
                        // List of expenses
                        NavigationLink(destination: ExpenseEditView(
                            
                            
                            
                            user: expense.user,
                            expenseID: expense.id,
                            name: expense.name,
                            price: expense.price,
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
    }
}
