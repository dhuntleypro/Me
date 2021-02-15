//
//  AddNewExpenseView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Kingfisher

struct AddNewExpenseView: View {
    @ObservedObject var viewModel = ExpenseViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image : Image?
    //@State var images : Image?
    
    func loadImage() {
        guard let selectedImage  = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    //    func loadImages() {
    //        guard let selectedImage  = selectedUIImage else { return }
    //        images = Image(uiImage: selectedImage)
    //    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
                Text("Add New Expense")
                    .font(.system(size: 17 , weight: .bold))
                    
                    .padding()
                
                Spacer()
                
                Button(action: {
                    viewModel.createExpense()
                    presentationMode.wrappedValue.dismiss()
                    
                    //  viewModel.createExpenses()
                }) {
                    Text("Create")
                        .modifier(myClearButtonSmallStatic(bgColor: .black))
                    
                }
                .padding()
            }
            .padding()
            
            ScrollView(.horizontal){
                HStack{
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        ZStack {
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .padding(12)
                                    .frame(width: 140, height: 140)
                                    .clipShape(Rectangle())
                                    .cornerRadius(10)
                                
                                
                            } else {
                                Button(action: { showImagePicker.toggle() }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "plus.circle")
                                        Text("Add Photo")
                                    }
                                }
                                .foregroundColor(.black)
                                .padding(12)
                                .frame(width: 140, height: 140)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(
                                            style: StrokeStyle(
                                                lineWidth: 2,
                                                dash: [5]
                                            )
                                        )
                                        .foregroundColor(.black)
                                )
                                .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                                    ImagePicker(image: $selectedUIImage)
                                })
                                
                            }
                        }
                    })
                    
                    
                    
                    
                    Spacer()
                }
                .padding()
                
                
                
            }
            Group {
                VStack {
                    HStack {
                        Text("Name :")
                        TextField("Name", text: $viewModel.name)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(minHeight: 30)
                    }
                    Divider()
                    
                    
                    HStack {
                        Text("Description :")
                        TextField("Description", text: $viewModel.description)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(minHeight: 30)
                    }
                    Divider()
                    
                    
                    HStack {
                        Text("Price :")
                        TextField("Price", text: $viewModel.price2)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(minHeight: 30)
                    }
                    Divider()
                    
                    HStack {
                        Text("Category :")
                        TextField("Category ", text: $viewModel.category)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(minHeight: 30)
                    }
                    Divider()
                    
                    
                    HStack {
                        Text("Release Date :")
                        TextField("Release Date ", text: $viewModel.releaseDate)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(minHeight: 30)
                    }
                    Divider()
                }
                Group {
                    VStack {
                        Text("or")
                        
                        HStack {
                            
                            Button(action: {
                                viewModel.createDemoExpense()
                            }, label: {
                                Text("Create Demo Expense")
                                  //  .modifier(myButton1(bgColor: .black))
                            })
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

//struct AddNewExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewExpenseView()
//    }
//}
