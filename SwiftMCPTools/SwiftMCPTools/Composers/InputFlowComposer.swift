//
//  InputFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
import SwiftUI

struct InputFlowComposer {
    static func compose(state: MCPState) -> InputFlow<InputView> {
        InputFlow(
            state: state,
            input: { state in
                InputView(
                    state: state,
                    onSend: {
                        let mcpService = SwiftVersionTool()
                        Task { @MainActor in
                            await InputAction(
                                state: state,
                                useCase: InputActionFactory.usecase(mcpService: mcpService),
                                mcpService: mcpService,
                                logger: ConsoleLogger()
                            ).execute()
                        }
                    }
                )
            }
        )
    }
}

struct InputFlow<Input:View>: View {
    @State private var state: MCPState
    private var input: (MCPState) -> Input
    
    init(
        state: MCPState,
        @ViewBuilder input: @escaping (MCPState) -> Input
    ) {
        self.state = state
        self.input = input
    }
    
    var body: some View {
        self.input(state)
    }
}
