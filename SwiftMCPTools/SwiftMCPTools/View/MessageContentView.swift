//
//  MessageContentView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct MessageContentView: View {
    let content: Content
    
    var body: some View {
        switch content {
        case .text(let text):
            Text(text)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                
        case .toolUse(_, let name, let input):
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "wrench.and.screwdriver.fill")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .red],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Using Tool: \(name)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                if !input.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Parameters:")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        ForEach(Array(input.keys.sorted()), id: \.self) { key in
                            HStack(alignment: .top, spacing: 6) {
                                Text("\(key):")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                
                                Text(input[key] ?? "")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemBackground).opacity(0.5))
                    )
                }
            }
            
        case .toolResult(_, let resultContent):
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green, .mint],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Tool Result")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Text(resultContent)
                    .font(.body)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green.opacity(0.3), lineWidth: 1)
                            )
                    )
            }
        }
    }
}