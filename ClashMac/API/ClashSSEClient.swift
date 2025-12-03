//
//  ClashSSEClient.swift
//  ClashMac
//
//  Created by Reverse Engineering
//

import Foundation
import Combine

class ClashSSEClient {
    static let shared = ClashSSEClient()
    
    private var eventSource: URLSessionDataTask?
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval.infinity
        self.session = URLSession(configuration: config)
    }
    
    func connect(to url: URL, secret: String?) -> AnyPublisher<String, Error> {
        var request = URLRequest(url: url)
        request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
        
        if let secret = secret {
            request.setValue("Bearer \(secret)", forHTTPHeaderField: "Authorization")
        }
        
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .tryMap { data -> String in
                guard let string = String(data: data, encoding: .utf8) else {
                    throw ClashAPIError.invalidResponse
                }
                return string
            }
            .eraseToAnyPublisher()
    }
    
    func disconnect() {
        eventSource?.cancel()
        eventSource = nil
    }
}

