//
//  ClashAPIError.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation

enum ClashAPIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case encodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "无效的 URL"
        case .invalidResponse:
            return "无效的响应"
        case .httpError(let code):
            return "HTTP 错误: \(code)"
        case .decodingError(let error):
            return "解码错误: \(error.localizedDescription)"
        case .encodingError(let error):
            return "编码错误: \(error.localizedDescription)"
        case .networkError(let error):
            return "网络错误: \(error.localizedDescription)"
        }
    }
}

