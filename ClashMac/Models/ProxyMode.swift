//
//  ProxyMode.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation

enum ProxyMode: String, Codable, CaseIterable {
    case rule = "rule"
    case global = "global"
    case direct = "direct"
    
    var displayName: String {
        switch self {
        case .rule:
            return "规则模式"
        case .global:
            return "全局模式"
        case .direct:
            return "直连模式"
        }
    }
}

