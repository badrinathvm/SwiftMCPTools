//
//  SwiftToolService.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

enum ToolError : Error {
    case toolNotSupported
}

struct SwiftVersionTool: MCPServerProtocol {
    var tools: [Tool] = [
        Tool(
            name: "swift_version",
            toolDescription: "Get the Swift Version",
            inputSchema: ["type" : "object"]
        )
    ]
    
    func call(_ tool: Tool) async throws -> String {
        guard tool.name == "swift_version" else { throw ToolError.toolNotSupported }
        return "Swift Version: \(ProcessInfo.processInfo.operatingSystemVersionString)"
    }
}
