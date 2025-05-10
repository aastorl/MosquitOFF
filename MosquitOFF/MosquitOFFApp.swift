//
//  MosquitOFFApp.swift
//  MosquitOFF
//
//  Created by Astor Ludueña  on 05/05/2025.
//

import SwiftUI

@main
struct MosquitOFFApp: App {
    @AppStorage("colorScheme") private var colorSchemeValue: String = "light"

    var colorScheme: ColorScheme {
        colorSchemeValue == "dark" ? .dark : .light
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(colorScheme)
        }
    }
}


#Preview {
    HomeView()
}
