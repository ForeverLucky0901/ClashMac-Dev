//
//  ProxyModeSwitcher.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import SwiftUI

struct ProxyModeSwitcher: View {
    @EnvironmentObject var store: ClashStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("代理模式")
                .font(.headline)
            
            Picker("模式", selection: $store.proxyMode) {
                ForEach(ProxyMode.allCases, id: \.self) { mode in
                    Text(mode.displayName).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: store.proxyMode) { newMode in
                store.updateProxyMode(newMode)
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}

