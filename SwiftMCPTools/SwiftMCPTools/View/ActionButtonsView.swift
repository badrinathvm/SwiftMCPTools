//
//  ActionButtonsView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct ActionButtonsView: View {
    let messages: [ChatMessage]
    let onNewQuestion: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            
            // Copy button
            Button(action: {
                let assistantContent = messages
                    .filter { $0.message.role == .assistant }
                    .map { message in
                        message.message.content.compactMap { content in
                            switch content {
                            case .text(let text):
                                return text
                            case .toolUse(_, let name, let input):
                                var result = "🔧 Using Tool: \(name)"
                                if !input.isEmpty {
                                    result += "\nParameters: \(input.map { "\($0.key): \($0.value)" }.joined(separator: ", "))"
                                }
                                return result
                            case .toolResult(_, let resultContent):
                                return "✅ Tool Result:\n\(resultContent)"
                            }
                        }.joined(separator: "\n")
                    }
                    .joined(separator: "\n\n")
                
                UIPasteboard.general.string = assistantContent
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "doc.on.doc.fill")
                    Text("Copy")
                        .fontWeight(.medium)
                        .lineLimit(1)
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .frame(minWidth: 100, minHeight: 44)
                .background(
                    LinearGradient(
                        colors: [.green, .mint],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: .green.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            
            // New Question button
            Button(action: {
                withAnimation(.easeInOut) {
                    onNewQuestion()
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                    Text("New Question")
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .frame(minWidth: 100, minHeight: 50)
                .background(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: .purple.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            
            Spacer()
        }
        .padding(.bottom, 20)
    }
}