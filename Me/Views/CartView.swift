//
//  CartView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var expenseVM : ExpenseViewModel


    
    var body: some View {
        VStack {
            
            ForEach(expenseVM.cartExpenses) { expense in
                
                Text(expense.expense.name)
            }
            
            Text("Monthly Expense Total : \(expenseVM.calculatorTotalPrice())")
                .font(.system(size: 13))
            
            
           
        }
    }
}

