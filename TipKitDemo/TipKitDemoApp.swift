//
//  TipKitDemoApp.swift
//  TipKitDemo
//
//  Created by Serhii Lukashchuk on 2025-01-18.
//

import SwiftUI
import TipKit

@main
struct TipKitDemoApp: App {
    
    init () {
        try? Tips.resetDatastore()
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
