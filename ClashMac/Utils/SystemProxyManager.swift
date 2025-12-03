//
//  SystemProxyManager.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation
import SystemConfiguration

class SystemProxyManager {
    static let shared = SystemProxyManager()
    
    private init() {}
    
    func setSystemProxy(enabled: Bool, host: String = "127.0.0.1", port: Int = 7890, exceptions: [String] = []) {
        // 系统代理设置需要通过 Helper 工具实现
        // 这里提供接口定义
    }
    
    func getSystemProxyStatus() -> (enabled: Bool, host: String?, port: Int?) {
        // 获取当前系统代理状态
        // 需要通过 Helper 工具实现
        return (false, nil, nil)
    }
}

