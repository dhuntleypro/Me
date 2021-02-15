//
//  WelcomeView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//


import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    @StateObject private var keyboardHandler = KeyboardHandler()
    @State var isOpenforStateAndCountries = false
    @State var continueWithWindow = false
    
    @State var lightBg = false
    @State var stateSearch = ""
    @State var storeName = ""
    @State var changeFontSize = false
    @State var bgColor = Color.black
    
    var body: some View {
        ZStack {
            
            // background
            Image("welcomeBg")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 1000)
                .overlay(Color(.black).opacity(0.8))
            VStack {
                Spacer()
                
                VStack (alignment: .center , spacing: 20){
                    Text("[ Me ]")
                        .font(.system(size: 60 , weight: .bold , design : .rounded))
                  
                }
                .foregroundColor(.white)
                .padding(.bottom, continueWithWindow ? 100 : 0)
                .animation(.easeIn)
                
                Spacer()
                
                
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "flag")
                        
                        HStack(spacing: 0) {
                            Text("Shopping from ")
                            Button(action: {
                                isOpenforStateAndCountries.toggle()
                            }, label: {
                                Text("United States").underline()
                            })
                        }
                        .foregroundColor(.white)
                    }
                    .font(.system(size: 12))
                    

                    
//                    NavigationLink(destination: IntroView()) {
//
//                    }
                    
                    Button(action: {
                        self.continueWithWindow.toggle()
                    }) {
                        Text("Login")
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 350, height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    
                   
                    
                    HStack {
                        
                        Button(action: {
                            self.continueWithWindow.toggle()
                        }) {
                            Text("Dont Have An Account?")
                                .foregroundColor(.white)
                                .underline()

                        }
                        .font(.system(size: 12))

                        
                    }
                }
                .padding(.bottom, 150)

            }
            // auto adjust text fields to keyboard height
            .padding(.bottom, keyboardHandler.keyboardHeight)
            .animation(.easeIn)
            .blur(radius: continueWithWindow ? 5 : 0)
           // .onChange(of:  keyboardHandler.keyboardHeight, perform: changeFontSize)
            
            
            
            BottomSheetContinueWith(isOpen: $continueWithWindow, lightBg: $lightBg, stateSearch: $stateSearch, bgColor: Color.black)
                .offset(y: 100)
        }
        .background(continueWithWindow ? (Color.white).opacity(0.4) : .clear)
        .edgesIgnoringSafeArea(.all)

        
        .navigationBarHidden(true)
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
