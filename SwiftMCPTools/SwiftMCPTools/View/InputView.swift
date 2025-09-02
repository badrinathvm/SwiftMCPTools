//
//  InputView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
import SwiftUI

struct InputView: View {
    @State private var state: MCPState
    var onSend: () -> Void
    
    init(
        state: MCPState,
        onSend: @escaping () -> Void
    ) {
        self.state = state
        self.onSend = onSend
    }
    
    var body: some View {
        VStack {
            // Always display messages
            ForEach(Array(state.messages.enumerated()), id: \.offset) { index, message in
                let isUser = message.message.role == .user
                VStack {
                    Text(message.content)
                        .padding(8)
                        .background(isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
            }
            
            // Show loading indicator when loading
            if state.isLoading {
                ProgressView("Loading...")
                    .padding()
            }
            
            // Always show input field (but disable when loading)
            HStack {
                TextField("Enter your message", text: $state.text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(state.isLoading)
                
                Button("Send") {
                    self.onSend()
                }
                .padding(.leading, 8)
                .disabled(state.text.trimmingCharacters(in: .whitespaces).isEmpty || state.isLoading)
            }
            .padding()
        }
    }
}
