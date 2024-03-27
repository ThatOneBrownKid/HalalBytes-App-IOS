//
//  RestViewModel.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class RestViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    private var db = Firestore.firestore()
    
    func createRestaurant(restaurant: Restaurant) {
        db.collection("restaurants").document(restaurant.id).setData([
            "id": restaurant.id,
            "name": restaurant.name,
            "cuisine": restaurant.cuisine,
            "phone": restaurant.phone,
            "street_address": restaurant.street_address,
            "city": restaurant.city,
            "state": restaurant.state,
            "zip_code": restaurant.zip_code
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(restaurant.id)")
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

