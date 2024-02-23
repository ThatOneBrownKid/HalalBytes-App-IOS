//
//  RegistrationView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 2/22/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Image("halalbytes-red")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 120)
                .padding(.vertical,32)
            
            VStack(spacing: 24){
                InputView(
                    text: $email,
                    title: "Email Address",
                    placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(
                    text: $fullname,
                    title: "Full Name",
                    placeholder: "Enter You Name")
                
                InputView(
                    text: $password,
                    title: "Password",
                    placeholder: "Enter Your Password",
                    isSecureField: true)
                
                InputView(
                    text: $confirmPassword,
                    title: "Confirm Password",
                    placeholder: "Confirm Your Password",
                    isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                print("Sign User Up...")
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 14))
            }

        }
    }
}

#Preview {
    RegistrationView()
}
