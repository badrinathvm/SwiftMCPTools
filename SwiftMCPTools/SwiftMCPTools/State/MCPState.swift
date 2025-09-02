//
//  MCPState.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

enum MCPModel {
    case openai
    case anthropic
}

@Observable
class MCPState {
    var text: String = ""
    var model: MCPModel = .openai
    var messages: [ChatMessage] = []
    var isLoading: Bool = false
}

