//
//  Modifiers.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct Modifiers: View {
    @State var want = false
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Text("Evkiiiiiien")
            })
            .modifier(myClearButtonAdjustable(bgColor: .black))
            
            
            Button(action: {}, label: {
                Text("Smmkkkkkkall")
            })
            .modifier(myClearButtonXSAdjustable(bgColor: .black))
            
            
            Button(action: {}, label: {
                Text("large")
            })
            .modifier(myClearButtonLargeAdjustable(bgColor: .black))
            
            Button(action: {}, label: {
                Text("Wakkkkknt")
            })
            .modifier(myClearButtonSmallStatic(bgColor: .black))
            
            Button(action: {}, label: {
                
                VStack(alignment: .leading ) {
                    Text("Standard: $12")
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    Text("The item will be shipped within 24 hours ")
                    
                }
            })
            .modifier(myClearButton2Rowleading(bgColor: .black))
            
            Button(action: {}, label: {
                Text("Checkout")
            })
            .modifier(myFullButtonAdjustable(bgColor: .black))
            
            Button(action: {
                want.toggle()
            }, label: {
                Text("Wkkkant")
                    .modifier(want ? myWhiteToBlackButton(black: false) : myWhiteToBlackButton(black: true))
                
            })
            
            
            
        }
        
        
    }
}

struct Modifiers_Previews: PreviewProvider {
    static var previews: some View {
        Modifiers()
    }
}


// See through Button
struct myClearButtonAdjustable: ViewModifier {
    var bgColor: Color
  
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(bgColor)
            .font(.system(size: 14, weight: .regular, design: .default))
            .frame(width: 100, height: 35, alignment: .center)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}

// See through Button
struct myClearButtonSmallStatic: ViewModifier {
    var bgColor: Color
  
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(bgColor)
            .font(.system(size: 12, weight: .regular, design: .default))
            .frame(width: 60, height: 30, alignment: .center)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}



// See through Button
struct myClearButtonXSAdjustable: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(bgColor)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.all, 7)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}

// See through Button
struct myClearButtonLargeAdjustable: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(bgColor)
            .padding(.leading, 102)
            .padding(.trailing, 102)
            .padding(.all, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}


// See through Button
struct myClearButton2Rowleading: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(bgColor)
        
          //  .padding(.leading, 2)
          //  .padding(.trailing, 50)
            .padding(.trailing, 60)
            .padding(.all, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}


// See through Button
struct myClearButton2RowleadingStatic: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(bgColor)
            .frame(width: 300, height: 100)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}



// Black Checkout *
struct myFullButtonAdjustable: ViewModifier {
    var bgColor: Color
  
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .frame(width: 300, height: 50, alignment: .center)
            .contentShape(Rectangle())
            .background(Color.black)
            .cornerRadius(10)

            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(bgColor, lineWidth: 1)
            )
    }
}

// white to Black  Button *
struct myWhiteToBlackButton: ViewModifier {
    var black: Bool
  
    func body(content: Content) -> some View {
        content
            .foregroundColor(black ? .white : .black)
            .font(.system(size: 10, weight: .regular, design: .default))
            .frame(width: 80, height: 30, alignment: .center)
            .contentShape(Rectangle())
            .background(Color(black ? .black : .white))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(black ? Color.black : Color.black, lineWidth: 1)
            )
    }
}



struct MyClearAppleButton: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: 16, weight: .semibold
                          , design: .rounded))
            .frame(width: 200, height: 50)
            .background(Color.white)
            .contentShape(Rectangle())
            .cornerRadius(6)
            .overlay(
                VStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(bgColor, lineWidth: 0.6)
                }
            )
    }
}


struct myButtonStyleSmall: ViewModifier {
    var prime: Color
    var myBackground: Color

    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(prime)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.all, 7)
            .cornerRadius(3)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(myBackground, lineWidth: 1)
            )
            .background(myBackground)
    }
}
