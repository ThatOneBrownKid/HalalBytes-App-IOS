//
//  User.swift
//  HalalBytes App (IOS)
//
//  Created by Shafin Alam on 2/12/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let admin: Bool
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "test@gmail.com", admin: false)
}
