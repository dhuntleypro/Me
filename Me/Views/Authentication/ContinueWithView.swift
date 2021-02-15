//
//  ContinueWithView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI


struct ContinueWithView: View {
    @State var signup = true
    var body: some View {
        VStack(spacing: 20) {
            
            
            // EMAIL
            NavigationLink(destination:
                            //  SignInWithEmailViewD2(signup: signup)
                            LoginView()
            ) {
                HStack {
                    Image(systemName: "envelope")
                        .font(.system(size:12))
                        .padding(.trailing, -2)
                    
                    Text("Continue with Email")
                }
                .padding(.horizontal, 5)
                
            }
            .modifier(MyClearAppleButton(bgColor: .black))
        }
    }
}

struct ContinueWithView_Previews: PreviewProvider {
    static var previews: some View {
        ContinueWithView()
    }
}
