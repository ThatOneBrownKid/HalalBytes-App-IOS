//
//  RestMapView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/31/24.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct RestaurantsMapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region: MKCoordinateRegion
    @State private var selectedRestaurant: RestaurantAnnotation?

    var annotations: [RestaurantAnnotation]

    init(annotations: [RestaurantAnnotation]) {
        self.annotations = annotations
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))

        if locationManager.hasUserLocation(), let currentLocation = locationManager.userLocation {
            _region = State(initialValue: MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
    }

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    VStack {
                        Text(annotation.title ?? "Unknown")
                            .foregroundColor(.black)
                            .font(.caption)
                            .fontWeight(.bold)
                            .frame(width: 80)
                            .fixedSize(horizontal: true, vertical: false)
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        self.selectedRestaurant = annotation
                    }
                }
            }
            .sheet(item: $selectedRestaurant) { annotation in
                RestDetailView(restaurant: convertAnnotationToRestaurant(annotation))
            }
            .onAppear {
                if let currentLocation = locationManager.userLocation {
                    updateRegion(location: currentLocation)
                }
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                newLocation.map(updateRegion)
            }
    }

    private func updateRegion(location: CLLocation) {
        region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }

    private func convertAnnotationToRestaurant(_ annotation: RestaurantAnnotation) -> Restaurant {
        return Restaurant(
            id: annotation.id,
            name: annotation.title ?? "",
            cuisine: annotation.subtitle ?? "",
            phone: annotation.phone,
            street_address: annotation.street_address,
            city: annotation.city,
            state: annotation.state,
            zip_code: annotation.zip_code,
            latitude: annotation.coordinate.latitude,
            longitude: annotation.coordinate.longitude,
            imageUrls: annotation.imageUrls
        )
    }
}

struct ImageCarouselView: View {
    var imageUrls: [String]

    var body: some View {
        TabView {
            ForEach(imageUrls, id: \.self) { imageUrl in
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 60)
    }
}

class RestaurantAnnotation: NSObject, Identifiable, MKAnnotation {
    let id: String
    let title: String?
    let subtitle: String?
    let phone: String
    let coordinate: CLLocationCoordinate2D
    let imageUrls: [String]
    let street_address: String
    let city: String
    let state: String
    let zip_code: String

    init(restaurant: Restaurant) {
        self.id = restaurant.id
        self.title = restaurant.name
        self.subtitle = restaurant.cuisine
        self.phone = restaurant.phone
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        self.imageUrls = restaurant.imageUrls
        self.street_address = restaurant.street_address
        self.city = restaurant.city
        self.state = restaurant.state
        self.zip_code = restaurant.zip_code
    }
}


