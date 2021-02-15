//
//  Cart.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

struct Cart: Identifiable {

    var id = UUID().uuidString
    var expense : Expense
    var quantity : Int
}
