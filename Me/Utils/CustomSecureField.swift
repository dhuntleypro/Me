//
//  CustomSecureField.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

// (tip) allow for custom color in tect field
struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
   
    let lightBg : Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.87)))
                    .padding(.leading, 40)
            }
            
            HStack(spacing: 16) {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(lightBg ? .black : .white)

                SecureField("", text: $text)
            }
        }
    }
}

