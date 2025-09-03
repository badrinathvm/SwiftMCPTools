//
//  InputRepository.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

struct InputRepository: InputRepositoryProtocol {
    let service: AnthropicService
    
    init(service: AnthropicService) {
        self.service = service
    }
    
    func send(messages: [Request.Message]) async throws -> Response {
        try await service.send(messages: messages)
    }
}
