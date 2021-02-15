//
//  AppNavigation.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI



// note : deleting a user from firebase does not sign them out
//Button(action: {
//    aut.signOut()
//
//}, label: {
//    Text("Log Out")
//        .foregroundColor(.red)
//
//})

struct AppNavigation: View {

    @EnvironmentObject var  viewModel: AuthViewModel
//    @ObservedObject var storeInformationVM = StoreInformationViewModel()
  //  @ObservedObject var viewModel = SearchViewModel()
    @State var searchText = ""

    
    @State var selectedIndex = 0
    var body: some View {
        Group {
            if viewModel.userSession != nil { // } ||  storeInformationVM. {
             
                
                NavigationView {
                    VStack {
                      //
                        IntroView()
                      //  IntroTabView()
                      //  UserTabControls(selectedIndex: $selectedIndex)
                    }
                    .navigationBarTitle(viewModel.tabTitle(forIndex: selectedIndex))
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            } else {
                NavigationView {
                    
                    WelcomeView()
                }
            }
        }
    }
}

struct AppNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigation()
    }
}
