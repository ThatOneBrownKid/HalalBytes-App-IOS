import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showDeleteConfirmation = false
    @State private var showEditProfile = false // For editing profile
    @State private var newFullName = "" // Temporary storage for the new full name
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section("General") {
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
                
                Section("Account") {
                    Button {
                        self.showEditProfile = true // Trigger the alert for editing profile
                    } label: {
                        SettingsRowView(imageName: "pencil.circle.fill",
                                        title: "Edit Profile",
                                        tintColor: .blue)
                    }
                    .alert("Edit Profile", isPresented: $showEditProfile) {
                        TextField("Full name", text: $newFullName)
                        Button("Cancel", role: .cancel) { }
                        Button("Save", role: .none) {
                            Task {
                                do {
                                    try await viewModel.updateUser(fullname: newFullName, email: nil)
                                    newFullName = "" // Reset after update
                                } catch {
                                    print("Failed to update profile: \(error)")
                                    // Handle errors here
                                }
                            }
                        }
                    } message: {
                        Text("Enter your new full name.")
                    }
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    

                    Button {
                        self.showDeleteConfirmation = true
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                    .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            Task {
                                do {
                                    try await viewModel.deleteAccount()
                                } catch {
                                    print("Failed to delete account: \(error)")
                                }
                            }
                        }
                    } message: {
                        Text("Are you sure you want to delete your account? This action cannot be undone.")
                    }
                }
            }
        }
    }
}

struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
