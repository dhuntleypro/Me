//
//  LoginView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//




import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel // may not need if on welcome view
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email = ""
    @State var password = ""
    
    // Errors
    @State private var showAlert = false
 //   @State private var authError : EmailAuthError?
    
    
    var body: some View {
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    Text("Login")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                    })
                    
                }
                .padding(.vertical)
                
                // cause nil to be printed in terminial
                LottieView(filename: "login-1")
                    .frame(width: 300, height: 300)


                
                VStack(alignment: .leading) {
                    Text("EMAIL OR USERNAME ")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical, 7)
                    
                    
                    
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope", lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Text("PASSWORD")
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical, 7)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"), lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            //   viewModel.
                        }, label: {
                            Text("Forgot Password?")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top)
                            
                        })
                    }
                }
                
                Button(action: {
                    viewModel.login(withEmail: email, password: password)
                }, label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                NavigationLink(destination: RegistrationView()
                                //    RegistrationView
                                .navigationBarBackButtonHidden(true)) {
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Text("Sign Up")
                            .font(.system(size: 13 , weight: .semibold))
                        
                    }
                    .foregroundColor(.white)
                    // .padding(.top,20)
                }
                
            }
            .padding()
            
        }
        .navigationBarHidden(true)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        LoginView()
        
    }
}
