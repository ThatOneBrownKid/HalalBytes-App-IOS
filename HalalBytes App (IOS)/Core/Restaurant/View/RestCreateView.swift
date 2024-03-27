//
//  RestCreateView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import SwiftUI

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

    var body: some View {
        VStack {
            Image("halalbytes-red") // Ensure you have a logo image in your assets
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
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }

            Button(action: {
                let newRestaurant = Restaurant(id: UUID().uuidString, // Generate a new UUID for the id
                                                   name: name,
                                                   cuisine: cuisine,
                                                   phone: phone,
                                                   street_address: streetAddress,
                                                   city: city,
                                                   state: state,
                                                   zip_code: zipCode)
                    restViewModel.createRestaurant(restaurant: newRestaurant)
                    dismiss()
            }) {
                Text("Add Restaurant")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.5)
            .padding()

            Spacer()
        }
        .navigationTitle("Add New Restaurant")
        .navigationBarTitleDisplayMode(.inline)
    }

    var formIsValid: Bool {
        // Simple validation for example purposes; adjust according to your needs
        !name.isEmpty && !cuisine.isEmpty && !phone.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !state.isEmpty && !zipCode.isEmpty
    }
}

struct CreateRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestCreateView().environmentObject(RestViewModel())
    }
}
