//
//  DangerZoneViewModel.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

@Observable
class DangerZoneViewModel {
    var itemCount = 0
    private let unsafeManager = UnsafeInventory()
    
    func runSimulation(logger: LogStore) {
        logger.clear()
        unsafeManager.items.removeAll()
        itemCount = 0
        logger.log("Launching 100 concurrent tasks against unsafe class...", type: .action)
        logger.log("⚠️ Watch console for runtime warnings or crashes.", type: .error)
        
        for i in 1...100 {
            Task {
                await unsafeManager.addItem("Item \(i)", logger: logger)
                await MainActor.run {
                    // Update the UI to show the resultin chaos
                    self.itemCount = self.unsafeManager.items.count
                }
            }
        }
    }
}
