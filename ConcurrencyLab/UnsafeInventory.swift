//
//  UnsafeInventory.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

// =========================================
// SCENARIO B: The Danger Zone
// Quadrant: Reentrant & NOT Thread-Safe
// =========================================
class UnsafeInventory {
    var items: [String] = []
    
    func addItem(_ item: String, logger: LogStore) async {
        logger.log("Start adding \(item)")
        // Reentrancy point
        try? await Task.sleep(nanoseconds: 100_000_000)
        // Data race hazard
        // Multiple threads hitting this line simultanously leads to memory corruption
        items.append(item)
        logger.log("Finished adding \(item)", type: .success)
    }
}
