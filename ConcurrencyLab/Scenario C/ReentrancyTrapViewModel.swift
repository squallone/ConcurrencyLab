//
//  ReentrancyTrapViewModel.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

@Observable
class ReentrancyTrapViewModel {
    var finalStock = 1
    private var actor = BuggyInventoryActor()
    
    func reset() {
        actor = BuggyInventoryActor()
        finalStock = 1
    }
    
    func runSimulation(logger: LogStore) {
        logger.clear()
        reset()
        logger.log("Starting Race Condition Simulation. Stock: 1", type: .action)
        
        Task {
            await withTaskGroup { group in
                group.addTask {
                    await self.actor.buyConsole(buyer: "A", logger: logger)
                }
                
                group.addTask {
                    await self.actor.buyConsole(buyer: "B", logger: logger)
                }
                await group.waitForAll()
            }
            
            let resultingStock = await actor.stockCount
            
            await MainActor.run {
                self.finalStock = resultingStock
                
                if resultingStock < 0 {
                    logger.log("🚨 BUG CONFIRMED: Stock is \(resultingStock). Double sell occurred", type: .error)
                }
            }
        }
    }
}
