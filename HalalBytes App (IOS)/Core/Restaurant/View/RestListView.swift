//
//  RestListView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import SwiftUI

struct RestListView: View {
    @StateObject var viewModel = RestViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.restaurants.indices, id: \.self) { index in
                NavigationLink(destination: RestDetailView(restaurant: viewModel.restaurants[index])) {
                    RestRowView(restaurant: viewModel.restaurants[index])
                        .onAppear {
                            if index == viewModel.restaurants.count - 1 { // Last cell
                                viewModel.fetchRestaurants()
                            }
                        }
                }
            }
            .navigationTitle("Restaurants")
            .onAppear {
                if viewModel.restaurants.isEmpty {
                    viewModel.fetchRestaurants()
                }
            }
        }
    }
}



