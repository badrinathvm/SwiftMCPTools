//
//  LoggerInterface.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation

protocol LoggerProtocol {
    func logInfo(_ message: String)
    func logError(_ message: String)
}


struct ConsoleLogger: LoggerProtocol {
    func logInfo(_ message: String) {
        print("🔍 [CONSOLE] \(message)")
    }
    
    func logError(_ message: String) {
        print("🔍 [CONSOLE:Error] \(message)")
    }

}
