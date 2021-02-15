//
//  RegistrationView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//


import SwiftUI

struct RegistrationView: View {
    // Which view is being presented and dismiss a screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // Firebase
   // @ObservedObject var viewModel = AuthViewModel()
    @EnvironmentObject var viewModel: AuthViewModel

    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    @State var username = ""
    
    @State private var showError = false
    @State private var errorString = ""
    
    @State var selectedUIImage: UIImage?
    @State var showImagePicker = false
    @State var image : Image?
    
 
    func loadImage() {
        guard let selectedImage  = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        ZStack {
            
            Color(.gray).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    
                    Text("Register")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        mode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                    })
                    
                }
                .padding(.vertical)
                
//                Spacer(minLength: 0)
                LottieView(filename: "login-1")
                    .frame(width: 200, height: 200)
                
//
//                // Error
//                if username.isEmpty || email.isEmpty || password.isEmpty || fullname.isEmpty {
//                    Text("Full in all fields")
//                    if username.count < 6 || password.count < 6 || fullname.count < 6 {
//
//                    Text("Full fields")
//                   }
//                } else {
//
//                }
                
//                if viewModel.validNameText.isEmpty || viewModel.validEmailAddressText.isEmpty  {
//
//                    Text("Full in all fields")
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .padding()
//                } else  if viewModel.validEmailAddressText.isEmpty {
//                    Text(viewModel.validEmailAddressText)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .padding()
//                } else  if viewModel.validPasswordText.isEmpty {
//                    Text(viewModel.validPasswordText)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .padding()
//                } else  if viewModel.passwordsMatch(_confirmPW: viewModel.confirmPassword) {
//                    Text(viewModel.validConfirmPasswordText)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .padding()
//                } else {
//
//                } else {
//                    Text("error")
//                }
            
                
               // Text(self.errorString)
                
                   

                VStack(spacing: 8) {
                    
                    // FULLNAME
                    CustomTextField(text: $fullname, placeholder: Text("Full Name") , imageName: "person", lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                    
                    // EMAIL
                    CustomTextField(text: $email, placeholder: Text("Email") , imageName: "envelope", lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                    
                    // USERNAME
                    CustomTextField(text: $username, placeholder: Text("Username") , imageName: "person", lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                    
                    
                    // PASSWORD
                    CustomSecureField(text: $password, placeholder: Text("Password"), lightBg: true)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                    
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        ZStack {
                            if let image = image {
                                VStack {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    
                                    Text("Add Profile Photo")
                                        .foregroundColor(.black)
                                }
                               
                                
                            } else {
                                VStack {
                                    LottieView(filename: "addPhoto")
                                        .frame(width: 70, height: 70)
                                    
                                    Text("Add Profile Photo")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        
                    })
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedUIImage)
                    })
                    
                    
                }
                .padding(.horizontal, 32)
                
                
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    
                    viewModel.register(email: email,
                                       password: password,
                                       username: username,
                                       fullname: fullname,
                                       profileImage: image
                    )
                    
//                   storeInformationVM.createStoreInformation()

                    
                    
                    print("Done")
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                })
                .disabled(username.isEmpty || email.isEmpty || password.isEmpty || fullname.isEmpty )

               // .disabled(!viewModel.isSignInComplete)

                
                
                Button(action: {
                    
                    mode.wrappedValue.dismiss()
                    
                }, label: {
                    HStack {
                        Text("Already have an account")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Text("Sign In")
                            .font(.system(size: 13 , weight: .semibold))
                        
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                    
                })
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
//            VStack {
//
//
//
//
//
//
//                Button(action: {
//
//                    mode.wrappedValue.dismiss()
//
//                }, label: {
//                    HStack {
//                       Text("Already have an account")
//                        .font(.system(size: 14))
//
//                        Text("Sign In")
//                            .font(.system(size: 13 , weight: .semibold))
//
//                    }
//                    .foregroundColor(.white)
//                    .padding(.bottom, 40)
//
//                })
//
//
//            }
        }
      
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
