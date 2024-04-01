//
//  RestAnnotations.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/31/24.
//

import Foundation
import MapKit

class RestAnnotations: NSObject, Identifiable, MKAnnotation {
    let id = UUID()
    let title: String?
    let subtitle: String?
    let phone: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, cuisine: String, phone: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = cuisine
        self.phone = phone
        self.coordinate = coordinate
    }
}
