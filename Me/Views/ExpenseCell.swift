//
//  ExpenseCell.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct ExpenseCell: View {
    
    var expense : Expense
    
    @State  var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20){
                HStack {
                    if expense.image == "" {
                        Image("fillImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                    } else {
                        Image(expense.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                    }
                    VStack {
                        Text(expense.name)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                        
                    }
                   
                }
                
                Spacer()
                
                Text("$\(expense.price2)")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.trailing, 10)
            
            }
            .padding()
            
            Divider()
        }
        
    }
}

//struct ExpenseCell2_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseCell2(expense: <#Expense#>)
//    }
//}
