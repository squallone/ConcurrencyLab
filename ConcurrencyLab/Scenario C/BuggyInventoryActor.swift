//
//  BuggyInventoryActor.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

// SCENARIO C: The Reentrancy Trap (Buggy Actor)
// Quadrant: Reentrant & Thread-Safe (But logically broken)
actor BuggyInventoryActor {
    var stockCount = 1
    
    func buyConsole(buyer: String, logger: LogStore) async {
        logger.log("🛒 \(buyer) checking stock. Current: \(stockCount)")
        
        guard stockCount > 0 else {
            logger.log("❌ \(buyer) failed: Out of stock", type: .error)
            return
        }
        
        logger.log("💳 \(buyer) processing payment (Suspending)...", type: .action)
        // 2. SUSPENSION POINT - The Actor unlocks here
        _ = await PaymentGateway.simulateCharge(seconds: 1.0)
        
        // 3. RESUMPTION - The world might have changed
        logger.log("▶️ \(buyer) resumed. Decrementing stock")
        // BUG: We assume stock is still 1. It might be 0 now
        stockCount -= 1
        
        logger.log("✅ \(buyer) purchased. New stock: \(stockCount)", type: .success)
    }
}
