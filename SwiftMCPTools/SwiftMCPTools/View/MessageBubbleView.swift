//
//  MessageBubbleView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        let isUser = message.message.role == .user
        
        HStack {
            if isUser { Spacer(minLength: 60) }
            
            VStack(alignment: .leading, spacing: 8) {
                // Role indicator
                HStack(spacing: 6) {
                    Image(systemName: isUser ? "person.circle.fill" : "cpu.fill")
                        .font(.caption)
                        .foregroundColor(isUser ? .blue : .purple)
                    
                    Text(isUser ? "You" : "Assistant")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(isUser ? .blue : .purple)
                }
                
                // Content based on type
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(Array(message.message.content.enumerated()), id: \.offset) { _, content in
                        MessageContentView(content: content)
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isUser ? 
                        LinearGradient(
                            colors: [.blue.opacity(0.1), .blue.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [.purple.opacity(0.1), .pink.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isUser ? 
                                LinearGradient(
                                    colors: [.blue.opacity(0.3), .blue.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ) :
                                LinearGradient(
                                    colors: [.purple.opacity(0.3), .pink.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
            
            if !isUser { Spacer(minLength: 60) }
        }
    }
}