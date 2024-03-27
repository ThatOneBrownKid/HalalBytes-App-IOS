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
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                Text(restaurant.cuisine)
                    .font(.subheadline)
            }
            Spacer()
            // Optionally, add more details or an image here
        }
        .padding()
    }
}
