//
//  MeApp.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase

@main
struct MeApp: App {
    
    init() {
        
        // Firebase
        FirebaseApp.configure()
        
        // Tab bar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().tintColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            AppNavigation().environmentObject(AuthViewModel.shared)

        }
    }
}
