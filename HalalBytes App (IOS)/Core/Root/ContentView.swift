//
//  ContentView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession != nil {
            MainTabView()
        } else {
            LoginView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()// Assuming you have a HomeView
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            RestListView()
                .tabItem {
                    Image(systemName: "storefront")
                    Text("Restaurants")
                }
            
            RestCreateView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add Restaurants")
                }
            
            ProfileView() // Assuming ProfileView is your intended profile view
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}
