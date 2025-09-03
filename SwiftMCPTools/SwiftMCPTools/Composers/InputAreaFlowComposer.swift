//
//  InputAreaFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import Foundation
import SwiftUI

struct InputAreaFlowComposer {
    static func compose(
        state: MCPState,
        onSend: @escaping () -> Void
    ) -> InputAreaFlow<TopInputAreaView> {
        InputAreaFlow(
            state: state,
            inputArea: { textBinding, isLoading in
                TopInputAreaView(
                    text: textBinding,
                    isLoading: isLoading,
                    onSend: onSend
                )
            }
        )
    }
}

struct InputAreaFlow<InputArea: View>: View {
    @State private var state: MCPState
    private var inputArea: (Binding<String>, Bool) -> InputArea
    
    init(
        state: MCPState,
        @ViewBuilder inputArea: @escaping (Binding<String>, Bool) -> InputArea
    ) {
        self.state = state
        self.inputArea = inputArea
    }
    
    var body: some View {
        self.inputArea($state.text, state.isLoading)
    }
}