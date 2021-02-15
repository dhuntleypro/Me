//
//  ExpenseEditView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//


import SwiftUI
import Firebase

struct ExpenseEditView: View {
    
    // firebase data
    @ObservedObject private var expenseVM = ExpenseViewModel()
    
    //  @State var showUpdatedAlert = false
    var expense : Expense
    
    @State  var showingAlert = false
    let user : User
    
    // main variant
    @State var expenseID = ""
    @State var name : String = ""
    @State var price : Double = 0.0
    @State var price2 : String = ""
    
    
    @State var description: String = ""
    @State var image: String = ""
    @State var images: String = ""
    @State var tags: [String] = [""]
    @State var brand : String = ""
    @State var category : String = ""
    @State var sku : String = ""
    @State var releaseDate : String = ""
    
    var body: some View {
        VStack {
            
            Group {
                HStack {
                    Text("Id :")
                    TextField("Id", text: self.$expenseID)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(minHeight: 30)
                }
                
                Divider()
                
                HStack {
                    Text("User Id ??  :")
                    TextField("User Id ", text: self.$name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(minHeight: 30)
                }
                
                Divider()
                
                HStack {
                    Text("Name :")
                    TextField("Name", text: self.$name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(minHeight: 30)
                }
                
                Divider()
                
                
                HStack {
                    Text("Description :")
                    TextField("Description", text: self.$description)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(minHeight: 30)
                }
                Divider()
                
                
                HStack {
                    Text("Brand :")
                    TextField("Brand", text: self.$brand)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(minHeight: 30)
                }
                Divider()
                
            }
            
            HStack {
                Text("Category :")
                TextField("Category ", text: self.$category)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
            }
            Divider()
            
            
            HStack {
                Text("Release Date :")
                TextField("Release Date ", text: self.$releaseDate)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
            }
            Divider()
            
            
            
            
            Button(action: {
                expenseVM.updateExpense(
                    p_ID: expenseID,
                    name: name,
                    price: price,
                    price2: price2,
                    description: description,
                    image: image,
                    tags: tags,
                    brand: brand,
                    category: category,
                    sku: sku,
                    releaseDate: releaseDate
                )
                
               
                
            }) {
                Text("Update")
            }
            .modifier(myFullButtonAdjustable(bgColor: .black))
            
            Button(action: {
                self.expenseVM.addToCart(expense: expense)
                
            }) {
                Text(expense.isAdded ? "Added to Cart" : "Add to Cart")
            }
            
         //   OrderButton(showingAlert: $showingAlert, expense: expense)

            Spacer()
            
        }
        .padding()
    }
    
    
    
    
}


//struct ExpenseEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseEditView()
//    }
//}
//



