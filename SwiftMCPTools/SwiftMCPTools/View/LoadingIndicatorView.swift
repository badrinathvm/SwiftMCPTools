//
//  LoadingIndicatorView.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import SwiftUI

struct LoadingIndicatorView: View {
    let isLoading: Bool
    
    var body: some View {
        if isLoading {
            HStack(spacing: 8) {
                ProgressView()
                    .scaleEffect(0.8)
                Text("Processing with MCP tools...")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground).opacity(0.8))
                    .shadow(radius: 2)
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .transition(.scale.combined(with: .opacity))
        }
    }
}