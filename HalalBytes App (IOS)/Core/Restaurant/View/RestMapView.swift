//
//  RestMapView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/31/24.
//

import SwiftUI
import MapKit

struct RestaurantsMapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var annotations: [RestaurantAnnotation] // Ensure this is your correct annotation type

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: annotations) { annotation in
                // This assumes usage of MapMarker, but you should use the appropriate view or marker type
                MapMarker(coordinate: annotation.coordinate, tint: .red)
            }
            .onAppear {
                setInitialRegion()
            }
    }

    private func setInitialRegion() {
        if let userLocation = locationManager.userLocation {
            region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
}

class RestaurantAnnotation: NSObject, Identifiable, MKAnnotation {
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
