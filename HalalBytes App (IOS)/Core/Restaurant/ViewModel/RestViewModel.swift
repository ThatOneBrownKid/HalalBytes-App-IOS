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

class RestViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    private var db = Firestore.firestore()
    
    
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
    func createRestaurant(restaurant: Restaurant, images: [UIImage]) {
        let group = DispatchGroup()
        var uploadedImageUrls = [String]()

        // Upload each image and collect their URLs
        for image in images {
            group.enter()
            uploadImage(image: image) { url in
                if let url = url {
                    uploadedImageUrls.append(url)
                }
                group.leave()
            }
        }

        // Once all images are uploaded, save the restaurant document with image URLs
        group.notify(queue: .main) {
            self.db.collection("restaurants").document(restaurant.id).setData([
                "id": restaurant.id,
                "name": restaurant.name,
                "cuisine": restaurant.cuisine,
                "phone": restaurant.phone,
                "street_address": restaurant.street_address,
                "city": restaurant.city,
                "state": restaurant.state,
                "zip_code": restaurant.zip_code,
                "imageUrls": uploadedImageUrls  // Save image URLs here
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(restaurant.id), with images: \(uploadedImageUrls)")
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
        db.collection("restaurants").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.restaurants = querySnapshot!.documents.compactMap { document in
                    try? document.data(as: Restaurant.self)
                }
            }
        }
    }
    
}

