//
//  DeveloperToolsService.swift
//  SwiftMCPTools
//
//  Created by Rani Badri on 9/1/25.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

enum ToolError : Error {
    case toolNotSupported
}

struct SwiftVersionTool {
    func getSwiftVersion() -> String {
        let processInfo = ProcessInfo.processInfo
        var info: [String] = []
        
        info.append("🔧 Swift Version Information")
        info.append("──────────────────────────")
        info.append("System Version: \(processInfo.operatingSystemVersionString)")
        
        #if os(iOS)
        info.append("Platform: iOS")
        #elseif os(macOS)
        info.append("Platform: macOS")
        #elseif os(watchOS)
        info.append("Platform: watchOS")
        #elseif os(tvOS)
        info.append("Platform: tvOS")
        #else
        info.append("Platform: Unknown")
        #endif
        
        info.append("Process Name: \(processInfo.processName)")
        info.append("Environment: \(processInfo.environment.count) variables")
        
        return info.joined(separator: "\n")
    }
}

struct DeveloperToolsService: MCPServerProtocol {
    var tools: [Tool] = [
        Tool(
            name: "swift_version",
            toolDescription: "Get the Swift Version and system information",
            inputSchema: ["type" : "object"]
        ),
        Tool(
            name: "device_info", 
            toolDescription: "Get detailed iOS device information including model, storage, memory, and capabilities",
            inputSchema: ["type": "object"]
        )
    ]
    
    func call(_ tool: Tool) async throws -> String {
        switch tool.name {
        case "swift_version":
            return SwiftVersionTool().getSwiftVersion()
        case "device_info":
            return DeviceInfoTool().getDeviceInfo()
        default:
            throw ToolError.toolNotSupported
        }
    }
}

struct DeviceInfoTool {
    
    func getDeviceInfo() -> String {
        var info: [String] = []
        
        #if canImport(UIKit)
        let device = UIDevice.current
        
        // Basic device info
        info.append("📱 Device Information")
        info.append("─────────────────────")
        info.append("Device Name: \(device.name)")
        info.append("Model: \(device.model)")
        info.append("System: \(device.systemName) \(device.systemVersion)")
        info.append("Identifier: \(device.identifierForVendor?.uuidString ?? "Unknown")")
        
        // Screen info
        let screen = UIScreen.main
        let bounds = screen.bounds
        let scale = screen.scale
        
        info.append("")
        info.append("📐 Screen Information")
        info.append("──────────────────────")
        info.append("Screen Size: \(bounds.width) x \(bounds.height) points")
        info.append("Scale Factor: \(scale)x")
        info.append("Resolution: \(bounds.width * scale) x \(bounds.height * scale) pixels")
        info.append("Screen Brightness: \(Int(screen.brightness * 100))%")
        
        // Battery info (if available)
        device.isBatteryMonitoringEnabled = true
        if device.batteryState != .unknown {
            info.append("")
            info.append("🔋 Battery Information")
            info.append("───────────────────────")
            let batteryLevel = device.batteryLevel >= 0 ? Int(device.batteryLevel * 100) : 0
            info.append("Battery Level: \(batteryLevel)%")
            
            let batteryState: String
            switch device.batteryState {
            case .charging: batteryState = "Charging"
            case .full: batteryState = "Full"
            case .unplugged: batteryState = "Unplugged"
            case .unknown: batteryState = "Unknown"
            @unknown default: batteryState = "Unknown"
            }
            info.append("Battery State: \(batteryState)")
        }
        
        // User interface info
        info.append("")
        info.append("🎨 Interface Information")
        info.append("─────────────────────────")
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            let interfaceOrientation = windowScene.interfaceOrientation
//            info.append("Orientation: \(interfaceOrientation.isLandscape ? "Landscape" : "Portrait")")
//        }
        
        #endif
        
        // Process and system info
        let processInfo = ProcessInfo.processInfo
        info.append("")
        info.append("⚙️ System Information")
        info.append("──────────────────────")
        info.append("Process Name: \(processInfo.processName)")
        info.append("System Uptime: \(String(format: "%.2f hours", processInfo.systemUptime / 3600))")
        info.append("Active Processor Count: \(processInfo.activeProcessorCount)")
        info.append("Physical Memory: \(String(format: "%.2f GB", Double(processInfo.physicalMemory) / 1_073_741_824))")
        
        return info.joined(separator: "\n")
    }
}

