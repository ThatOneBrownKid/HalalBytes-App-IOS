import SwiftUI
import PhotosUI

struct RestCreateView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var restViewModel: RestViewModel

    @State private var name = ""
    @State private var cuisine = ""
    @State private var phone = ""
    @State private var streetAddress = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @State private var showAlert = false
    @State private var imageIndexToRemove: Int?

    // Grid layout configuration
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]  // Adjust the number of columns as needed

    var body: some View {
        NavigationStack {
            VStack {
                Image("halalbytes-red")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)

                ScrollView {
                    VStack(spacing: 20) {
                        InputView(text: $name, title: "Restaurant Name", placeholder: "Enter Restaurant Name")
                        InputView(text: $cuisine, title: "Cuisine", placeholder: "Enter Cuisine Type")
                        InputView(text: $phone, title: "Phone Number", placeholder: "Enter Phone Number")
                        InputView(text: $streetAddress, title: "Street Address", placeholder: "Enter Street Address")
                        InputView(text: $city, title: "City", placeholder: "Enter City")
                        InputView(text: $state, title: "State", placeholder: "Enter State")
                        InputView(text: $zipCode, title: "Zip Code", placeholder: "Enter Zip Code")
                        
                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 0, matching: .images, photoLibrary: .shared()) {
                            Label("Select Images", systemImage: "photo.on.rectangle.angled")
                                .labelStyle(.titleAndIcon)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .onChange(of: selectedItems) { newItems in
                            Task {
                                selectedImages.removeAll()
                                for item in newItems {
                                    if let imageData = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: imageData) {
                                        selectedImages.append(Image(uiImage: uiImage))
                                    }
                                }
                            }
                        }
                        
                        // Display the selected images in a grid
                        LazyVGrid(columns: columns, spacing: 10) {
                                            ForEach(selectedImages.indices, id: \.self) { index in
                                                ZStack(alignment: .topTrailing) { // Align the button to the top right of each image
                                                    selectedImages[index]
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                                    Button(action: {
                                                        // Directly remove the selected image without confirmation
                                                        selectedImages.remove(at: index)
                                                        selectedItems.remove(at: index)
                                                    }) {
                                                        Image(systemName: "minus.circle.fill")
                                                            .resizable()
                                                                        .scaledToFit()
                                                                        .symbolRenderingMode(.palette) // Enables multi-color rendering
                                                                        .foregroundStyle(.white, .red) // First color for the glyph, second color for the circle
                                                                        .font(.system(size: 20)) // Adjust the size as needed
                                                                        .frame(width: 20, height: 20) // Adjust the frame to your preference
                                                                        .padding(4) // Add some padding if needed
                                                    }
//                                                    .background(Color.white.opacity(0.6)) // Slightly opaque background to ensure visibility
//                                                    .clipShape(Circle()) // Make the background circular
//                                                    .padding(4) // Add padding to distance the button from the image edges
                                                }
                                            }
                                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }

                Button(action: {
                    // Prepare UIImages for uploading
                    var uiImages = [UIImage]()
                    for photosPickerItem in selectedItems {
                        Task {
                            if let data = try? await photosPickerItem.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                                uiImages.append(uiImage)
                            }
                            
                            if uiImages.count == selectedItems.count {
                                // All images have been converted to UIImages, proceed to upload and create the restaurant
                                let newRestaurant = Restaurant(id: UUID().uuidString, name: name, cuisine: cuisine, phone: phone, street_address: streetAddress, city: city, state: state, zip_code: zipCode, imageUrls: [])
                                restViewModel.createRestaurant(restaurant: newRestaurant, images: uiImages)
                                dismiss()
                            }
                        }
                    }
                }) {
                    Text("Add Restaurant")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(!formIsValid || selectedItems.isEmpty) // Ensure there's at least one image selected along with valid form details
                .opacity(formIsValid && !selectedItems.isEmpty ? 1 : 0.5)
                .padding()


                Spacer()
            }
            .navigationTitle("Add New Restaurant")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var formIsValid: Bool {
        !name.isEmpty && !cuisine.isEmpty && !phone.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !state.isEmpty && !zipCode.isEmpty
    }
}

struct CreateRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestCreateView().environmentObject(RestViewModel())
    }
}
