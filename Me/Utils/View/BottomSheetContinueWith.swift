//
//  BottomSheetContinueWith.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//


import SwiftUI


struct BottomSheetContinueWith: View {
    
    @Binding var isOpen : Bool
    @Binding var lightBg : Bool
    @Binding var stateSearch : String
    
    
    @State var bgColor = Color.black
    
    
    var body: some View {
        BottomSheetView(isOpen: $isOpen, bgColor: bgColor, lightBg: $lightBg, maxHeight: 550) {
            
            VStack(alignment: .center, spacing: 20) {
                
                Text("Continue With?")
                    .font(.system(size: 20 , weight: .bold))
                    .padding(.trailing)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                
                //
                ContinueWithView()
                
                
                
//                // APPLE
//                SignInWithAppleView()
//                    .frame(width: 200, height: 50)
              
                // SKIP
                NavigationLink(destination: IntroView()) {
                    Text("Skip")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .underline()
                }
            }
            .padding()
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct  BottomSheetContinueWith_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContinueWith(isOpen: .constant(true), lightBg: .constant(true), stateSearch: .constant(""), bgColor: Color.black)
    }
}
