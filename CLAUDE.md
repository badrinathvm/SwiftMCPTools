# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SwiftMCPTools is an iOS application that demonstrates Model Context Protocol (MCP) integration with AI language models. The app provides a chat interface where users can interact with Claude AI, which can invoke MCP tools for development tasks like checking Swift versions.

## Build and Development Commands

### Building and Running
```bash
# Open project in Xcode
open SwiftMCPTools/SwiftMCPTools.xcodeproj

# Build from command line
xcodebuild -project SwiftMCPTools/SwiftMCPTools.xcodeproj -scheme SwiftMCPTools build

# Run tests
xcodebuild test -project SwiftMCPTools/SwiftMCPTools.xcodeproj -scheme SwiftMCPTools -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Testing
- **Unit Tests**: Located in `SwiftMCPToolsTests/`
- **UI Tests**: Located in `SwiftMCPToolsUITests/`

## Architecture

The application follows **Clean Architecture** principles with clear separation of concerns:

### Core Components

**State Management:**
- `MCPState`: Observable state class managing conversation messages, loading state, and user input
- Uses SwiftUI's `@Observable` for reactive UI updates

**Dependency Injection Pattern:**
- `MCPFlowComposer`: Main flow composer that manages state and view composition
- `InputFlowComposer`: Composes the input flow with all dependencies
- `InputActionFactory`: Factory for creating use cases with proper dependency injection

**Clean Architecture Layers:**

1. **Domain Layer** (`Domain/`)
   - `MCPServerProtocol`: Interface for MCP tool servers
   - `LoggerProtocol`: Logging abstraction
   - `InputUseCase`: Business logic for processing messages

2. **Data Layer** (`Data/`)
   - `AnthropicService`: HTTP client for Claude API integration
   - `InputRepository`: Repository pattern for message handling
   - `InputDecorator`: Decorator pattern for logging repository operations

3. **Presentation Layer** (`View/`, `Action/`)
   - `InputView`: Main chat interface with gradient UI design
   - `InputAction`: Action handler coordinating between UI and business logic

**Message Flow Architecture:**
1. User input → `InputAction` → `InputUseCase` → `InputRepository` → `AnthropicService`
2. Claude API response may contain tool calls
3. Tool calls are executed via `MCPServerProtocol` implementations
4. Tool results are sent back to Claude for final response
5. Complete conversation is displayed in the UI

### Key Data Models

**Message System:**
- `Request.Message`: API request format with role and content array
- `ChatMessage`: UI wrapper with ID for SwiftUI list rendering
- `Content` enum: Handles text, tool use, and tool result content types

**Tool Integration:**
- `Tool`: Defines MCP tool schema (name, description, input schema)
- `SwiftVersionTool`: Example MCP tool implementation for getting Swift version

## UI Design Patterns

The app features a modern gradient-based design:
- **Top-to-Bottom Flow**: Input field at top → Results in middle → Action buttons at bottom
- **Gradient Themes**: Blue/purple gradients throughout the interface
- **Message Differentiation**: 
  - First assistant response: CPU icon, "Assistant Response" (purple)
  - Second assistant response: Brain icon, "LLM Response" (blue)
- **Action Buttons**: Copy response content and start new question

## MCP Tool Development

To add new MCP tools:

1. **Create Tool Implementation:**
   ```swift
   struct YourTool: MCPServerProtocol {
       var tools: [Tool] = [/* tool definitions */]
       func call(_ tool: Tool) async throws -> String { /* implementation */ }
   }
   ```

2. **Register Tool in Composer:**
   Update `InputFlowComposer.compose()` to use your tool instead of `SwiftVersionTool()`

3. **Tool Schema:**
   Tools must define proper JSON schema in `inputSchema` for parameter validation

## Important Implementation Details

**API Integration:**
- Uses Anthropic Claude API (claude-sonnet-4-20250514 model)
- API key is currently hardcoded in `InputUseCase.swift` (should be externalized)
- Supports tool calling with automatic tool result processing

**Error Handling:**
- `ToolError.toolNotSupported` for invalid tool names
- Network errors are propagated through the use case chain

**UI State Management:**
- Messages are filtered to show only assistant responses in results
- Loading state prevents duplicate requests
- Copy functionality extracts all assistant content including tool usage details

## File Structure Conventions

- **Actions**: User interaction handlers
- **Composers**: Dependency injection and flow composition
- **Data**: Repository pattern and external service integration
- **Domain**: Business logic and protocol definitions
- **Tools**: MCP tool implementations
- **View**: SwiftUI interface components
- **State**: Observable state management