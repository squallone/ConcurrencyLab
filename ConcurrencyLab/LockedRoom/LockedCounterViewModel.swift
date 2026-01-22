//
//  LockedCounterViewModel.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

// =========================================
// SCENARIO A: The "Locked Room"
// Quadrant: Non-Reentrant & Thread-Safe
// =========================================
@Observable
class LockedCounterViewModel {
    var count = 0
    private let lock = NSLock()
    
    func runSimulator(logger: LogStore) {
        logger.clear()
        count = 0
        
        logger.log("Starting 10 concurrent thread..", type: .action)
                
        for i in 1...10 {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                
                // Critical section
                // The thread is blocked here until the lock is acquired
                self.lock.lock()
                logger.log("Thread \(i) acquired lock. Working...")
                // Simulate sync work
                Thread.sleep(forTimeInterval: 0.1)
                let newCount = self.count + 1
                self.count = newCount
                logger.log("Thread \(i) released lock. Count is now \(newCount)", type: .success)
                self.lock.unlock()
                
            }
        }
    }
}
