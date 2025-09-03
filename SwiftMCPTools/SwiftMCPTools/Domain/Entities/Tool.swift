//
//  Tool.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

struct Tool: Encodable {
    enum CodingKeys: String, CodingKey {
        case name, toolDescription = "description", inputSchema = "input_schema"
    }
    
    let name: String
    let toolDescription: String
    let inputSchema: [String: String]
}

struct ChatMessage: Identifiable {
    let id: UUID
    let message: Request.Message
    
    init(message: Request.Message) {
        self.id = UUID()
        self.message = message
    }
    
    var content: String {
        message.content
            .compactMap { content in
                switch content {
                case .text(let text):
                    return text
                case .toolUse(_, let name, _):
                    return "🔧 \(name)"
                case .toolResult(_, let content):
                    return "✅ \(content)"
                }
            }
            .joined(separator: "\n")
    }
}
