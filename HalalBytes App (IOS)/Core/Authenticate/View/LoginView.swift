//
//  LoginView.swift
//  HalalBytes
//
//  Created by Azwad Alam on 2/22/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel:  AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                //image
                Image("halalbytes-red")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 120)
                    .padding(.vertical,32)
                
                
                // form fields
                VStack(spacing: 24){
                    InputView(
                        text: $email,
                        title: "Email Address",
                        placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(
                        text: $password,
                        title: "Password",
                        placeholder: "Enter Your Password",
                        isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                // sign in button
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
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
                
                // sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Dont have an account?")
                        Text("Sign Up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
