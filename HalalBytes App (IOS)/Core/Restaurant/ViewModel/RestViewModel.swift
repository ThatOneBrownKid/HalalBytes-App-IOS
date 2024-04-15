//
//  RestViewModel.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import CoreLocation

class RestViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    private var db = Firestore.firestore()
    private var lastDocumentSnapshot: DocumentSnapshot?
    private var isFetching = false
    private let itemsPerPage = 10
    
    
    // Helper function to upload an image to Firebase Storage
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageData = image.jpegData(compressionQuality: 0.8)
        let imageName = UUID().uuidString + ".jpg"
        let imageRef = storageRef.child("restaurant_images/\(imageName)")

        imageRef.putData(imageData!, metadata: nil) { metadata, error in
            guard error == nil else {
                print("Failed to upload image: \(error!.localizedDescription)")
                completion(nil)
                return
            }

            imageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Download URL not found.")
                    completion(nil)
                    return
                }
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    
    // Modify createRestaurant to handle image uploads
    func createRestaurant(restaurant: Restaurant, images: [UIImage], completion: @escaping (Bool, String?) -> Void) {
        let fullAddress = "\(restaurant.street_address), \(restaurant.city), \(restaurant.state) \(restaurant.zip_code)"

        geocodeAddress(fullAddress) { [weak self] coordinate in
            guard let self = self, let coordinate = coordinate else {
                print("Could not geocode address")
                completion(false, "Could not geocode address")
                return
            }

            var updatedRestaurant = restaurant
            updatedRestaurant.latitude = coordinate.latitude
            updatedRestaurant.longitude = coordinate.longitude

            let group = DispatchGroup()
            var uploadedImageUrls = [String]()

            for image in images {
                group.enter()
                self.uploadImage(image: image) { url in
                    if let url = url {
                        uploadedImageUrls.append(url)
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.db.collection("restaurants").document(updatedRestaurant.id).setData([
                    "id": updatedRestaurant.id,
                    "name": updatedRestaurant.name,
                    "cuisine": updatedRestaurant.cuisine,
                    "phone": updatedRestaurant.phone,
                    "street_address": updatedRestaurant.street_address,
                    "city": updatedRestaurant.city,
                    "state": updatedRestaurant.state,
                    "zip_code": updatedRestaurant.zip_code,
                    "latitude": updatedRestaurant.latitude,
                    "longitude": updatedRestaurant.longitude,
                    "imageUrls": uploadedImageUrls
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                        completion(false, error.localizedDescription)
                    } else {
                        print("Document added with ID: \(updatedRestaurant.id)")
                        completion(true, nil)
                    }
                }
            }
        }
    }

    
    func updateRestaurant(restaurant: Restaurant) {
        db.collection("restaurants").document(restaurant.id).updateData([
            "name": restaurant.name,
            "cuisine": restaurant.cuisine,
            "phone": restaurant.phone,
            "street_address": restaurant.street_address,
            "city": restaurant.city,
            "state": restaurant.state,
            "zip_code": restaurant.zip_code
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
    func deleteRestaurant(restaurantId: String) {
        db.collection("restaurants").document(restaurantId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                // Optionally, update your local restaurants array to reflect this change
                DispatchQueue.main.async {
                    self.restaurants.removeAll { $0.id == restaurantId }
                }
            }
        }
    }
        
    
    func fetchRestaurants() {
            guard !isFetching else { return }
            isFetching = true
            
            var query: Query = db.collection("restaurants").limit(to: itemsPerPage)
            
            // If we have a last document, start after it
            if let lastSnapshot = lastDocumentSnapshot {
                query = query.start(afterDocument: lastSnapshot)
            }
            
            query.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    self.isFetching = false
                } else {
                    let newRestaurants = querySnapshot!.documents.compactMap { document in
                        try? document.data(as: Restaurant.self)
                    }
                    
                    if newRestaurants.count > 0 {
                        self.lastDocumentSnapshot = querySnapshot!.documents.last
                        self.restaurants.append(contentsOf: newRestaurants)
                    }
                    
                    self.isFetching = false
                }
            }
        }
    
    
    func geocodeAddress(_ address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error == nil else {
                print("Geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
    
    
}

