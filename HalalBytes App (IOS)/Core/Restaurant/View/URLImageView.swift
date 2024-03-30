//
//  URLImageView.swift
//  HalalBytes App (IOS)
//
//  Created by Shafin Alam on 3/29/24.
//

import SwiftUI

struct URLImageView: View {
    let urlString: String

    var body: some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image("placeholder") // Use a local placeholder image in case of URL failure
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}


//#Preview {
//    URLImageView()
//}
