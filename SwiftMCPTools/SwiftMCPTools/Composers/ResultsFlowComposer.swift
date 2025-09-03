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
            resultsView: { messages, isLoading in
                ResultsDisplayView(
                    messages: messages,
                    isLoading: isLoading,
                    onNewQuestion: onNewQuestion
                )
            }
        )
    }
}

struct ResultsFlow<ResultsView: View>: View {
    @State private var state: MCPState
    private var resultsView: ([ChatMessage], Bool) -> ResultsView
    
    init(
        state: MCPState,
        @ViewBuilder resultsView: @escaping ([ChatMessage], Bool) -> ResultsView
    ) {
        self.state = state
        self.resultsView = resultsView
    }
    
    var body: some View {
        self.resultsView(state.messages, state.isLoading)
    }
}