//
//  Restaurant.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import Foundation

struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let cuisine: String
    let phone: String
    let street_address: String
    let city: String
    let state: String
    let zip_code: String
    var imageUrls: [String]
    
    
    var fullAddress: String {
            "\(street_address), \(city), \(state) \(zip_code)"
        }
}

