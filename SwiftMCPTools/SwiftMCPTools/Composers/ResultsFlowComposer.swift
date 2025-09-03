//
//  ResultsFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import Foundation
import SwiftUI

struct ResultsFlowComposer {
    static func compose(
        state: MCPState,
        onNewQuestion: @escaping () -> Void
    ) -> ResultsFlow<ResultsDisplayView> {
        ResultsFlow(
            state: state,
            resultsView: { messages, isLoading, errorMessage in
                ResultsDisplayView(
                    messages: messages,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onNewQuestion: onNewQuestion
                )
            }
        )
    }
}

struct ResultsFlow<ResultsView: View>: View {
    @State private var state: MCPState
    private var resultsView: ([ChatMessage], Bool, String?) -> ResultsView
    
    init(
        state: MCPState,
        @ViewBuilder resultsView: @escaping ([ChatMessage], Bool, String?) -> ResultsView
    ) {
        self.state = state
        self.resultsView = resultsView
    }
    
    var body: some View {
        self.resultsView(state.messages, state.isLoading, state.errorMessage)
    }
}