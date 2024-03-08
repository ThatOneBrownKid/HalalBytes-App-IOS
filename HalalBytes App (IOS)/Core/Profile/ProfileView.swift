//
//  ProfileView.swift
//  HalalBytes App (IOS)
//
//  Created by Shafin Alam on 2/12/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showDeleteConfirmation = false
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack (alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                Section ("General"){
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section ("Account"){
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    
                    Button {
                        // Toggle the state to show the confirmation alert
                        self.showDeleteConfirmation = true
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                    .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            Task {
                                // Call the deleteAccount method here
                                do {
                                    try await viewModel.deleteAccount()
                                } catch {
                                    // Handle any errors here, e.g., by showing another alert
                                    print("Failed to delete account: \(error)")
                                }
                            }
                        }
                    } message: {
                        Text("Are you sure you want to delete your account? This action cannot be undone.")
                    }
                }
            }        }
    }
}

struct ProfileView_Preview: PreviewProvider {
    static var previews: some View{
        ProfileView()
    }
}
