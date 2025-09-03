//
//  ContentView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import SwiftUI

struct ContentView: View {
    let mcpComposer = MCPComposer()
    var body: some View {
        MCPFlowComposer(detail: mcpComposer.compose)
    }
}

// Main Flow Composer
struct MCPFlowComposer<Detail: View>: View {
    @State var mcpState: MCPState
    let detail: (MCPState) -> Detail
    
    init(detail: @escaping (MCPState) -> Detail) {
        self._mcpState = State(wrappedValue: MCPState())
        self.detail = detail
    }
    
    var body: some View {
        self.detail(self.mcpState)
    }
}

struct MCPComposer {
     func compose(state: MCPState) -> some View {
         return MCPDetail(
            headerFlow: HeaderFlowComposer.compose(),
            inputFlow: InputFlowComposer.compose(state: state)
         )
    }
}
