//
//  ConfigManager.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation

class ConfigManager {
    static let shared = ConfigManager()
    
    private let configDirectory: URL
    private let fileManager = FileManager.default
    
    private init() {
        let appSupport = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        configDirectory = appSupport.appendingPathComponent("ClashMac", isDirectory: true)
        
        // 创建配置目录
        try? fileManager.createDirectory(at: configDirectory, withIntermediateDirectories: true)
    }
    
    func saveConfig(_ config: ClashConfiguration, name: String = "config.yaml") throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(config)
        let url = configDirectory.appendingPathComponent(name)
        try data.write(to: url)
    }
    
    func loadConfig(name: String = "config.yaml") throws -> ClashConfiguration {
        let url = configDirectory.appendingPathComponent(name)
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(ClashConfiguration.self, from: data)
    }
    
    func listConfigs() -> [String] {
        guard let files = try? fileManager.contentsOfDirectory(at: configDirectory, includingPropertiesForKeys: nil) else {
            return []
        }
        return files.filter { $0.pathExtension == "yaml" || $0.pathExtension == "yml" }
            .map { $0.lastPathComponent }
    }
}

