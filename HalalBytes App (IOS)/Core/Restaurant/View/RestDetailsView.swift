//
//  RestDetailsView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/28/24.
//

import SwiftUI

struct RestDetailView: View {
    var restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(restaurant.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(restaurant.cuisine)
                .font(.title2)

            Text(restaurant.phone)
                .font(.title3)

            Text(restaurant.fullAddress)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
