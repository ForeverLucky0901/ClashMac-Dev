//
//  ClashStore.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ClashStore: ObservableObject {
    static let shared = ClashStore()
    
    @Published var isRunning: Bool = false
    @Published var proxyMode: ProxyMode = .rule
    @Published var systemProxyEnabled: Bool = false
    @Published var proxyExceptionsText: String = ""
    @Published var configuration: ClashConfiguration?
    @Published var proxies: [ProxyNode] = []
    @Published var selectedProxy: String?
    
    private let apiClient = ClashAPIClient.shared
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        loadConfiguration()
    }
    
    func loadConfiguration() {
        Task {
            do {
                let config = try await apiClient.getConfig()
                self.configuration = config
                
                if let mode = config.mode {
                    self.proxyMode = ProxyMode(rawValue: mode) ?? .rule
                }
            } catch {
                print("加载配置失败: \(error)")
            }
        }
    }
    
    func updateProxyMode(_ mode: ProxyMode) {
        Task {
            guard var config = configuration else { return }
            config.mode = mode.rawValue
            
            do {
                try await apiClient.updateConfig(config)
                self.proxyMode = mode
                self.configuration = config
            } catch {
                print("更新代理模式失败: \(error)")
            }
        }
    }
    
    func toggleSystemProxy() {
        systemProxyEnabled.toggle()
        // 实现系统代理切换逻辑
    }
    
    func startClash() {
        // 启动 Clash 进程
        isRunning = true
    }
    
    func stopClash() {
        // 停止 Clash 进程
        isRunning = false
    }
}

