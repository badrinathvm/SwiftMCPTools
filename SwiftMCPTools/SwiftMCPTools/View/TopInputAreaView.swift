//
//  TopInputAreaView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct TopInputAreaView: View {
    @Binding var text: String
    let isLoading: Bool
    let onSend: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                TextField(
                    "What would you like me to help with?",
                    text: $text,
                    axis: .vertical
                )
                .textFieldStyle(PlainTextFieldStyle())
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.4), .purple.opacity(0.4)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(color: .blue.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                .disabled(isLoading)
                .lineLimit(6)
                
                Button(action: onSend) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(
                            text.trimmingCharacters(in: .whitespaces).isEmpty || isLoading ?
                            LinearGradient(colors: [.gray.opacity(0.6)], startPoint: .leading, endPoint: .trailing) :
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .disabled(text.trimmingCharacters(in: .whitespaces).isEmpty || isLoading)
            }
        }
        .padding([.horizontal, .bottom], 16)
    }
}