//
//  ResultAction.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import Foundation
import SwiftUI

struct ResultAction {
    private let state: MCPState
    
    init(state: MCPState) {
        self.state = state
    }
    
    func execute() {
        state.messages.removeAll()
        state.text = ""
    }
}