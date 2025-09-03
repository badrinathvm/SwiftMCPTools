//
//  MCPDetail.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import SwiftUI

struct MCPDetail<
    HeaderFlow: View,
    InputFlow: View
>: View {
    
    var headerFlow: HeaderFlow
    var inputFlow: InputFlow
    
    init(
        headerFlow: HeaderFlow,
        inputFlow: InputFlow
    ) {
        self.headerFlow = headerFlow
        self.inputFlow = inputFlow
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Beautiful gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.1),
                        Color.purple.opacity(0.1),
                        Color.pink.opacity(0.05)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    self.headerFlow
                    
                    // Input content
                    self.inputFlow
                }
            }
        }
    }
}



