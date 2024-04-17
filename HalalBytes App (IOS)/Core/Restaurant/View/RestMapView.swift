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
    @State private var region: MKCoordinateRegion

    var annotations: [RestaurantAnnotation]

    init(annotations: [RestaurantAnnotation]) {
        self.annotations = annotations
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))

        // Initialize locationManager to potentially update the region immediately
        if locationManager.hasUserLocation(), let currentLocation = locationManager.userLocation {
            _region = State(initialValue: MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
    }

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: annotations) { annotation in
                MapMarker(coordinate: annotation.coordinate, tint: .red)
            }
        
            .onAppear {
                if let currentLocation = locationManager.userLocation {
                    updateRegion(location: currentLocation)
                }
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                newLocation.map(updateRegion)
            }
            .accessibilityIdentifier("RestaurantsMapView")
    }

    private func updateRegion(location: CLLocation) {
        region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
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
