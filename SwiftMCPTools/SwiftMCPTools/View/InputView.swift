//
//  InputView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
import SwiftUI

struct InputView<
    InputAreaFlow: View,
    LoadingFlow: View,
    ResultsFlow: View
>: View {
    
    var inputAreaFlow: InputAreaFlow
    var loadingFlow: LoadingFlow
    var resultsFlow: ResultsFlow
    
    init(
        inputAreaFlow: InputAreaFlow,
        loadingFlow: LoadingFlow,
        resultsFlow: ResultsFlow
    ) {
        self.inputAreaFlow = inputAreaFlow
        self.loadingFlow = loadingFlow
        self.resultsFlow = resultsFlow
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Input area
            self.inputAreaFlow
            
            // Loading indicator  
            self.loadingFlow
            
            // Results display
            self.resultsFlow
        }
    }
}
