//
//  User.swift
//  HalalBytes App (IOS)
//
//  Created by Shafin Alam on 2/22/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let wmail: String
    
    var initials: String {
        
    }
}
