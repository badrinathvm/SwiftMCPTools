//
//  InputUseCase.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

struct InputActionFactory {
    static func usecase(mcpService: MCPServerProtocol) -> InputUseCase {
        let repository = InputRepository(
            service: AnthropicService(
                apiKey: "API_KEY",
                tools: mcpService.tools)
        )
        let dataSource = InputDecorator(logger: ConsoleLogger(), repository: repository)
        return InputUseCase(dataSource: dataSource)
    }
}

struct InputUseCase {
    private let dataSource: InputRepositoryProtocol
    
    init(dataSource: InputRepositoryProtocol) {
        self.dataSource = dataSource
    }
    
    func send(messages: [Request.Message]) async throws -> Response {
        try await dataSource.send(messages: messages)
    }
}
