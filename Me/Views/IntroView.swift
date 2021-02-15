//
//  IntroView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct IntroView: View {
    @State var isShowingCreateNewExpenseView = false
    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: ExpenseView(isShowingCreateNewExpenseView: $isShowingCreateNewExpenseView)) {
                Text("Expenses")
                    .foregroundColor(.black)
                    .underline()
                    .bold()
            }
            .padding()

            
            Divider()
            
            Spacer()
            
            
            
            
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
