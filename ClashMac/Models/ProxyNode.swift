//
//  ProxyNode.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation

struct ProxyNode: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let type: String
    let server: String?
    let port: Int?
    let cipher: String?
    let password: String?
    let udp: Bool?
    let obfs: String?
    let protocol: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case name
        case type
        case server
        case port
        case cipher
        case password
        case udp
        case obfs
        case `protocol`
    }
}

