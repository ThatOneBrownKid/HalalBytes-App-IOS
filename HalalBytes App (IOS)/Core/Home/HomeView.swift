//
//  HomeView.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 3/27/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            Image("halalbytes-red")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 120)
                .padding(.vertical,32)
            
            Text("Ramadan Mubarak!")
            Text("Explore the best halal food in Columbus")
        }
    }
}

#Preview {
    HomeView()
}
