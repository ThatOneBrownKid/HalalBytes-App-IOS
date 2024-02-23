//
//  HalalBytes_App__IOS_App.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 2/22/24.
//

import SwiftUI
import Firebase

@main
struct HalalBytes_App__IOS_App: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
