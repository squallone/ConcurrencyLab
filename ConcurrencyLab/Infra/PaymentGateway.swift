//
//  PaymentGateway.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/19/26.
//

import Foundation

/// Helper for simulating network delay
struct PaymentGateway {
    static func simulateCharge(seconds: TimeInterval = 1.0) async -> Bool {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
        return true
    }
}
