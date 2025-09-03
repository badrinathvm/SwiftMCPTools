//
//  InputFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
import SwiftUI

struct InputFlowComposer {
    static func compose(state: MCPState) -> InputFlow<InputView<InputAreaFlow<TopInputAreaView>, LoadingFlow<LoadingIndicatorView>, ResultsFlow<ResultsDisplayView>>> {
        
        return InputFlow(
            state: state,
            input: { state in
                InputView(
                    inputAreaFlow: InputAreaFlowComposer.compose(
                        state: state,
                        onSend: {
                            let mcpService = DeveloperToolsService()
                            Task { @MainActor in
                                await InputAction(
                                    state: state,
                                    useCase: InputActionFactory.usecase(mcpService: mcpService),
                                    mcpService: mcpService,
                                    logger: ConsoleLogger()
                                ).execute()
                            }
                        }
                    ),
                    loadingFlow:
                        LoadingFlowComposer.compose(state: state),
                    resultsFlow:
                        ResultsFlowComposer.compose(
                            state: state,
                            onNewQuestion: {
                                ResultAction(state: state).execute()
                            }
                        )
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
