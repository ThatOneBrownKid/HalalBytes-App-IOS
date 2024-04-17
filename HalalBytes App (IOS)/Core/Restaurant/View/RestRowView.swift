//
//  RestRowView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import SwiftUI

struct RestRowView: View {
    let restaurant: Restaurant

    var body: some View {
        HStack {
            if let firstImageUrlString = restaurant.imageUrls.first, let firstImageUrl = URL(string: firstImageUrlString) {
                            AsyncImage(url: firstImageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 60, height: 60) // Adjust the size as needed
                            .cornerRadius(10)
                            .padding(.trailing, 10)
                        } else {
                            // Display a placeholder or nothing if there's no image
                            Color.gray.opacity(0.3)
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                        }
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                Text(restaurant.cuisine)
                    .font(.subheadline)
            }
            Spacer()
            // Optionally, add more details or an image here
        }
        .accessibilityIdentifier("RestaurantCell_\(restaurant.id)")
        .padding()
    }
}
