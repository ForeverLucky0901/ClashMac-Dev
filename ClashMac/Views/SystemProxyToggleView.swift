//
//  SystemProxyToggleView.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import SwiftUI

struct SystemProxyToggleView: View {
    @EnvironmentObject var store: ClashStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("系统代理")
                .font(.headline)
            
            Toggle("启用系统代理", isOn: $store.systemProxyEnabled)
                .onChange(of: store.systemProxyEnabled) { newValue in
                    store.toggleSystemProxy()
                }
            
            if store.systemProxyEnabled {
                TextField("代理例外（逗号分隔）", text: $store.proxyExceptionsText)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}

