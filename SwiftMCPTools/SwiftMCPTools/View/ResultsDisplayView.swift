//
//  ResultsDisplayView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct ResultsDisplayView: View {
    let messages: [ChatMessage]
    let isLoading: Bool
    let errorMessage: String?
    let onNewQuestion: () -> Void
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    if messages.isEmpty && !isLoading && errorMessage == nil {
                        // Welcome message when no messages and no errors
                        VStack(spacing: 12) {
                            Image(systemName: "sparkles.rectangle.stack")
                                .font(.system(size: 60))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            Text("Ready to assist with your development tasks")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            
                            Text("Enter your question above to get started")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 40)
                    } else {
                        // Show error message if present
                        if let errorMessage = errorMessage {
                            ErrorMessageView(errorMessage: errorMessage)
                                .id("error-message")
                        }
                        
                        // Show assistant messages
                        if !messages.isEmpty {
                            ForEach(Array(messages.enumerated()), id: \.offset) { index, message in
                                if message.message.role == .assistant {
                                    ResultMessageView(
                                        message: message,
                                        responseIndex: messages.filter { $0.message.role == .assistant }.firstIndex(where: { $0.id == message.id }) ?? 0
                                    )
                                    .id(index)
                                }
                            }
                        }
                        
                        // Action buttons at the bottom of results (show if we have messages or an error)
                        if !isLoading && (!messages.isEmpty || errorMessage != nil) {
                            ActionButtonsView(
                                messages: messages,
                                onNewQuestion: onNewQuestion
                            )
                            .padding(.top, 20)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .onChange(of: messages.count) { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(messages.count - 1, anchor: .bottom)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}