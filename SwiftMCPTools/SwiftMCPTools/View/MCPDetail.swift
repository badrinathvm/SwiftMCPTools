//
//  MCPDetail.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import SwiftUI

struct MCPDetail<
    InputFlow: View
>: View {
    
    var inputFlow: InputFlow
    
    init(
        inputFlow: InputFlow
    ) {
        self.inputFlow = inputFlow
    }
    
    var body: some View {
        VStack {
            self.inputFlow
        }
    }
}



