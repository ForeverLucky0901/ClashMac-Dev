//
//  UserConfigPickerView.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import SwiftUI

struct UserConfigPickerView: View {
    @EnvironmentObject var store: ClashStore
    @State private var selectedConfig: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("配置文件")
                .font(.headline)
            
            HStack {
                Picker("选择配置", selection: $selectedConfig) {
                    Text("默认配置").tag(nil as String?)
                    // 这里应该列出可用的配置文件
                }
                .pickerStyle(.menu)
                
                Button("导入配置") {
                    // 实现配置导入逻辑
                }
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}

