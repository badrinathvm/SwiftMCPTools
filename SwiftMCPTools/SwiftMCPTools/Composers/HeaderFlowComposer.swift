//
//  HeaderFlowComposer.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/3/25.
//

import Foundation
import SwiftUI

struct HeaderFlowComposer {
    static func compose() -> HeaderFlow<HeaderView> {
        HeaderFlow(
            header: {
                HeaderView()
            }
        )
    }
}

struct HeaderFlow<Header: View>: View {
    private var header: () -> Header
    
    init(
        @ViewBuilder header: @escaping () -> Header
    ) {
        self.header = header
    }
    
    var body: some View {
        self.header()
    }
}