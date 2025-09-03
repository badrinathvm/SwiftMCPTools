//
//  LoadingFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import Foundation
import SwiftUI

struct LoadingFlowComposer {
    static func compose(state: MCPState) -> LoadingFlow<LoadingIndicatorView> {
        LoadingFlow(
            state: state,
            loadingView: { isLoading in
                LoadingIndicatorView(isLoading: isLoading)
            }
        )
    }
}

struct LoadingFlow<LoadingView: View>: View {
    @State private var state: MCPState
    private var loadingView: (Bool) -> LoadingView
    
    init(
        state: MCPState,
        @ViewBuilder loadingView: @escaping (Bool) -> LoadingView
    ) {
        self.state = state
        self.loadingView = loadingView
    }
    
    var body: some View {
        self.loadingView(state.isLoading)
    }
}