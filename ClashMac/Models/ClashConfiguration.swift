//
//  ClashConfiguration.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation

struct ClashConfiguration: Codable {
    var port: Int?
    var socksPort: Int?
    var allowLan: Bool?
    var mode: String?
    var logLevel: String?
    var externalController: String?
    var secret: String?
    var proxies: [ProxyNode]?
    var proxyGroups: [ProxyGroup]?
    var rules: [String]?
    
    enum CodingKeys: String, CodingKey {
        case port
        case socksPort = "socks-port"
        case allowLan = "allow-lan"
        case mode
        case logLevel = "log-level"
        case externalController = "external-controller"
        case secret
        case proxies
        case proxyGroups = "proxy-groups"
        case rules
    }
}

struct ProxyGroup: Codable {
    let name: String
    let type: String
    let proxies: [String]
}

