//
//  CustomTextField.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

// (tip) allow for custom color in tect field
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName : String
    let lightBg : Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.87)))
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(lightBg ? .black : .white)
                
                TextField("", text: $text)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder:  Text(""), imageName: "envolope", lightBg: true)
            .frame(height: 300)
            .background(Color.green)
   
            
    }
}
