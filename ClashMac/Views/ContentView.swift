//
//  ContentView.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: ClashStore
    
    var body: some View {
        NavigationView {
            SidebarView()
            MainView()
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

struct SidebarView: View {
    var body: some View {
        List {
            Label("概览", systemImage: "chart.bar")
            Label("代理", systemImage: "network")
            Label("规则", systemImage: "list.bullet")
            Label("日志", systemImage: "doc.text")
            Label("设置", systemImage: "gear")
        }
        .listStyle(.sidebar)
        .frame(minWidth: 200)
    }
}

struct MainView: View {
    @EnvironmentObject var store: ClashStore
    
    var body: some View {
        VStack(spacing: 20) {
            SystemProxyToggleView()
            ProxyModeSwitcher()
            UserConfigPickerView()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

