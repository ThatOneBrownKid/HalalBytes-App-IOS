//
//  ContentView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 2/12/24.
//

import SwiftUI
import MapKit


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
    @StateObject var restViewModel = RestViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
//                    Text("Home")
                }
            
            RestListView()
                .tabItem {
                    Image(systemName: "storefront")
//                    Text("Restaurants")
                }
            
            RestCreateView()
                .tabItem {
                    Image(systemName: "plus")
//                    Text("Add Restaurants")
                }
            
            RestaurantsMapView(annotations: restViewModel.restaurants.map {
                            RestaurantAnnotation(title: $0.name, cuisine: $0.cuisine, phone: $0.phone, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
                        })
                        .tabItem {
                            Image(systemName: "map")
                        }
                        .onAppear {
                            restViewModel.fetchRestaurants() // Fetch restaurants when this tab is selected
                        }
            
            ProfileView() // Assuming ProfileView is your intended profile view
                .tabItem {
                    Image(systemName: "person")
//                    Text("Profile")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
