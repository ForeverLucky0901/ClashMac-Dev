//
//  ClashMacApp.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import SwiftUI

@main
struct ClashMacApp: App {
    @StateObject private var store = ClashStore.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
    }
}

