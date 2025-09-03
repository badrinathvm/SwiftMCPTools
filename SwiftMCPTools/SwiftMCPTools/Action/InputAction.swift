//
//  InputAction.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
import SwiftUI

struct InputAction {
    private let state: MCPState
    private let useCase: InputUseCase
    private let mcpService: MCPServerProtocol
    private let logger: LoggerProtocol
    
    init(
        state: MCPState,
        useCase: InputUseCase,
        mcpService: MCPServerProtocol,
        logger: LoggerProtocol
    ) {
        self.state = state
        self.useCase = useCase
        self.mcpService = mcpService
        self.logger = logger
    }
    
    func execute() async {
        do {
            state.isLoading = true
            
            let userMessage = ChatMessage(
                message: Request.Message(
                    role: .user,
                    content: [.text(text: state.text)]
                )
            )
            
            let response = try await sendMessage(userMessage)
            
            for content in response.content {
                if case .toolUse(let id, let name, _) = content {
                    try await useTool(withID: id, name: name)
                }
            }
            
            state.isLoading = false
        } catch {
            print("Error: \(error)")
            state.isLoading = false
        }
    }
    
    private func sendMessage(_ message: ChatMessage) async throws -> Response {
        state.messages.append(message)
        
        let requestMessages = state.messages.map { $0.message }
        // Makes an LLM Call here
        let response = try await self.useCase.send(messages: requestMessages)
        
        let assistantMessage = ChatMessage(
            message: Request.Message(role: .assistant, content: response.content)
        )
        state.messages.append(assistantMessage)
        
        return response
    }
    
    private func useTool(withID id: String, name: String) async throws {
        guard let tool = mcpService.tools.first(where: { $0.name == name }) else {
            print("Tool with name \(name) not found.")
            return
        }
        
        let content = try await mcpService.call(tool)
        let toolResultMessage = ChatMessage(
            message: Request.Message(
                role: .user,
                content: [.toolResult(toolUseId: id, content: content)]
            )
        )
        
        _ = try await sendMessage(toolResultMessage)
    }
}








