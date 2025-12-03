//
//  ClashController.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation
import AppKit

class ClashController {
    static let shared = ClashController()
    
    private var clashProcess: Process?
    private let mihomoPath: String
    
    private init() {
        // 获取 mihomo 可执行文件路径
        if let bundlePath = Bundle.main.resourcePath {
            self.mihomoPath = "\(bundlePath)/mihomo"
        } else {
            self.mihomoPath = "/usr/local/bin/mihomo"
        }
    }
    
    func start(configPath: String) throws {
        guard clashProcess == nil else {
            return
        }
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: mihomoPath)
        process.arguments = ["-f", configPath]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        
        try process.run()
        clashProcess = process
    }
    
    func stop() {
        clashProcess?.terminate()
        clashProcess = nil
    }
    
    var isRunning: Bool {
        return clashProcess?.isRunning ?? false
    }
}

