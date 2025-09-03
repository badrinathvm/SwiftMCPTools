//
//  MCPServerInterface.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

protocol MCPServerProtocol {
    var tools: [Tool] { get }
    func call(_ tool: Tool) async throws -> String
}

protocol InputRepositoryProtocol {
    func send(messages: [Request.Message]) async throws -> Response
}
