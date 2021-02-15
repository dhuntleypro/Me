//
//  ExpenseCell.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct ExpenseCell: View {
    
    var expense : Expense
    
    
    var body: some View {
        HStack {
            
            VStack(alignment: .center, spacing: 10) {
                Image(expense.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 100)
                

                HStack(alignment: .center){
                    Text(expense.name)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .frame(width: 170)
                        .foregroundColor(.primary)
                    
                }
                
                Text("$\(expense.price.clean)")
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(width: 170)
                    .foregroundColor(.primary)
                    .padding(.bottom, 30)

                
                
            }
            .padding(.leading, 30)
            .padding(.top, 20)
        }
    }
}

//struct ExpenseCell2_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseCell2(expense: <#Expense#>)
//    }
//}
