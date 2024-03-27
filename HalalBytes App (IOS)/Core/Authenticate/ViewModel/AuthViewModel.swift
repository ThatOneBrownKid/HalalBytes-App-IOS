//
//  AuthViewModel.swift
//  HalalBytes App (IOS)
//
//  Created by Shafin Alam on 2/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.userSession = user
            if let _ = user {
                Task {
                    await self?.fetchUser()
                }
            } else {
                self?.currentUser = nil
            }
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.errorMessage = "Failed to login: \(error.localizedDescription)"
                self.showErrorAlert = true
            }
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, admin: false)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.errorMessage = "Failed to create user: \(error.localizedDescription)"
                self.showErrorAlert = true
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func updateUser(fullname: String?, email: String?) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var updateData: [String: Any] = [:]
        
        if let fullname = fullname {
            updateData["fullname"] = fullname
        }
        if let email = email {
            updateData["email"] = email
        }
        
        do {
            try await Firestore.firestore().collection("users").document(uid).updateData(updateData)
            // Optionally, update the local user model if needed
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update user with error \(error.localizedDescription)")
            throw error
        }
    }

    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { return }
        
        // First, delete the user data from Firestore
        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
        } catch {
            print("DEBUG: Failed to delete user data from Firestore with error \(error.localizedDescription)")
            throw error // rethrow to handle it outside if needed
        }
        
        // Then, delete the user account from Firebase Authentication
        do {
            try await user.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to delete user account with error \(error.localizedDescription)")
            throw error // rethrow to handle it outside if needed
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.userSession = nil
            self.currentUser = nil
            return
        }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        } catch {
            print("Failed to fetch user: \(error)")
            self.userSession = nil
            self.currentUser = nil
        }
    }
}
