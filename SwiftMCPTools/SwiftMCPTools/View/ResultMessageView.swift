//
//  ResultMessageView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct ResultMessageView: View {
    let message: ChatMessage
    let responseIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Role indicator
            HStack(spacing: 8) {
                Image(systemName: responseIndex == 1 ? "brain.head.profile.fill" : "cpu.fill")
                    .font(.subheadline)
                    .foregroundStyle(
                        LinearGradient(
                            colors: responseIndex == 1 ? [.blue, .cyan] : [.purple, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text(responseIndex == 1 ? "LLM Response" : "Assistant Response")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(responseIndex == 1 ? .blue : .purple)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(message.message.content.enumerated()), id: \.offset) { _, content in
                    MessageContentView(content: content)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [.purple.opacity(0.2), .pink.opacity(0.2)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}