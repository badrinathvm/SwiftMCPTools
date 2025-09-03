//
//  AnthropicService.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
 
struct AnthropicService {
 
    private let apiKey: String
    private let tools: [Tool]
    
    init(apiKey: String, tools: [Tool]) {
        self.apiKey = apiKey
        self.tools = tools
    }
    
    func send(messages: [Request.Message]) async throws -> Response {
        var request = URLRequest(url: URL(string: "https://api.anthropic.com/v1/messages")!)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        
        let body = Request(model: "claude-sonnet-4-20250514", messages: messages, max_tokens: 1024, tools: tools)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

struct Request: Encodable {
    let model: String
    let messages: [Message]
    let max_tokens: Int
    let tools: [Tool]?
 
    struct Message: Encodable {
        enum Role: String, Encodable {
            case user
            case assistant
        }
        
        let role: Role
        let content: [Content]
    }
}

struct Response: Decodable {
    let content: [Content]
}

enum Content: Codable {
    case text(text: String)
    case toolUse(id: String, name: String, input: [String: String])
    case toolResult(toolUseId: String, content: String)

    private enum CodingKeys: String, CodingKey {
        case type, text, id, name, input, tool_use_id, content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "text":
            let text = try container.decode(String.self, forKey: .text)
            self = .text(text: text)
        case "tool_use":
            let id = try container.decode(String.self, forKey: .id)
            let name = try container.decode(String.self, forKey: .name)
            let input = try container.decode([String: String].self, forKey: .input)
            self = .toolUse(id: id, name: name, input: input)
        case "tool_result":
            let toolUseId = try container.decode(String.self, forKey: .tool_use_id)
            let content = try container.decode(String.self, forKey: .content)
            self = .toolResult(toolUseId: toolUseId, content: content)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown content type: \(type)")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .text(let text):
            try container.encode("text", forKey: .type)
            try container.encode(text, forKey: .text)
        case .toolUse(let id, let name, let input):
            try container.encode("tool_use", forKey: .type)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(input, forKey: .input)
        case .toolResult(let toolUseId, let content):
            try container.encode("tool_result", forKey: .type)
            try container.encode(toolUseId, forKey: .tool_use_id)
            try container.encode(content, forKey: .content)
        }
    }
}
