//
//  ClashAPIClient.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation
import Combine

class ClashAPIClient {
    static let shared = ClashAPIClient()
    
    private let baseURL: URL
    private let secret: String?
    private let session: URLSession
    
    private init() {
        // 默认配置，需要根据实际情况调整
        self.baseURL = URL(string: "http://127.0.0.1:9090")!
        self.secret = nil
        self.session = URLSession.shared
    }
    
    func configure(baseURL: URL, secret: String?) {
        // 配置 API 客户端
    }
    
    private func makeRequest(path: String, method: String = "GET", body: Data? = nil) -> URLRequest? {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let secret = secret {
            request.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
    
    func getVersion() async throws -> [String: Any] {
        guard let request = makeRequest(path: "/version") else {
            throw ClashAPIError.invalidURL
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClashAPIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ClashAPIError.httpError(httpResponse.statusCode)
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw ClashAPIError.decodingError(NSError(domain: "ClashAPI", code: -1))
        }
        
        return json
    }
    
    func getConfig() async throws -> ClashConfiguration {
        guard let request = makeRequest(path: "/configs") else {
            throw ClashAPIError.invalidURL
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClashAPIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ClashAPIError.httpError(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(ClashConfiguration.self, from: data)
    }
    
    func updateConfig(_ config: ClashConfiguration) async throws {
        guard let request = makeRequest(path: "/configs", method: "PUT", body: try JSONEncoder().encode(config)) else {
            throw ClashAPIError.invalidURL
        }
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClashAPIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ClashAPIError.httpError(httpResponse.statusCode)
        }
    }
    
    func getProxies() async throws -> [String: Any] {
        guard let request = makeRequest(path: "/proxies") else {
            throw ClashAPIError.invalidURL
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClashAPIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ClashAPIError.httpError(httpResponse.statusCode)
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw ClashAPIError.decodingError(NSError(domain: "ClashAPI", code: -1))
        }
        
        return json
    }
}

