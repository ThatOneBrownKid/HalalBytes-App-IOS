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
            
            // Images Carousel
                        if !restaurant.imageUrls.isEmpty {
                            TabView {
                                ForEach(restaurant.imageUrls, id: \.self) { imageUrlString in
                                    if let imageUrl = URL(string: imageUrlString) {
                                        AsyncImage(url: imageUrl) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView() // Display a progress view while the image is loading
                                                    .frame(height: 200)
                                            case .success(let image):
                                                image.resizable()
                                                     .aspectRatio(contentMode: .fill)
                                                     .frame(width: UIScreen.main.bounds.width, height: 200)
                                                     .clipped()
                                            case .failure:
                                                Image(systemName: "photo") // Display some default image or icon in case of failure
                                                    .frame(height: 200)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            .frame(height: 200)
                        }
            
            Text(restaurant.cuisine)
                .font(.title2)
            
            Text(restaurant.phone)
                .font(.title3)

            Text(restaurant.fullAddress)
                .font(.body)
            
            Spacer()
        }
        .accessibilityIdentifier("RestDetailView")
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
