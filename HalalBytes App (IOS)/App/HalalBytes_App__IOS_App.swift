//
//  HalalBytes_App__IOS_App.swift
//  HalalBytes App (IOS)
//
//  Created by Azwad Alam on 2/22/24.
//

import SwiftUI

@main
struct HalalBytes_App__IOS_App: App {
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
