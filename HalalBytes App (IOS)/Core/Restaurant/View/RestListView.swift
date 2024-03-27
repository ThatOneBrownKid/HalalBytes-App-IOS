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
            List(viewModel.restaurants, id: \.id) { restaurant in
                RestRowView(restaurant: restaurant)
            }
            .navigationTitle("Restaurants")
            .onAppear {
                viewModel.fetchRestaurants()
            }
        }
    }
}


