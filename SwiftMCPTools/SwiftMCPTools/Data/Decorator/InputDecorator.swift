//
//  InputDecorator.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

struct InputDecorator: InputRepositoryProtocol {
    private let logger: LoggerProtocol
    private let repository: InputRepositoryProtocol
    
    init(
        logger: LoggerProtocol,
        repository: InputRepositoryProtocol
    ) {
        self.logger = logger
        self.repository = repository
    }
    
    func send(messages: [Request.Message]) async throws -> Response {
        do {
            logger.logInfo("Getting messages...")
            let messages = try await repository.send(messages: messages)
            logger.logInfo("Fetched messages successfully")
            return messages
        } catch  {
            logger.logError(error.localizedDescription)
            throw error
        }
    }
}
