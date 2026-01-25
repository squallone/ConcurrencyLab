//
//  LogStore.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/19/26.
//

import Foundation
import SwiftUI

@Observable
/// A thread-safe logger to display runtime interleaving in the UI
class LogStore {
    var logs: [LogEntry] = []
    
    struct LogEntry: Identifiable {
        let id: UUID = UUID()
        let timestamp = Date()
        let message: String
        let type: LogType
    }
    
    enum LogType {
        case info, action, error, success
        var color: Color {
            switch self {
            case .info: return .gray
            case .action: return .blue
            case .error: return .red
            case .success: return .green
            }
        }
    }
    
    // 'nonisolated': "Anyone can call this func from any thread"
    nonisolated func log(_ message: String, type: LogType = .info) {
        Task { @MainActor in
            logs.append(.init(message: message, type: type))
        }
    }
    
    nonisolated func clear() {
        Task { @MainActor in
            logs.removeAll()
        }
    }
}
