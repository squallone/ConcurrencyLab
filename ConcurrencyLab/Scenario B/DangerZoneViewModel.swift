//
//  DangerZoneViewModel.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

@Observable
class DangerZoneViewModel {
    var currentDisplayedName = ""
    var corruptionDetected = false
    
    private let unsafeProfile = UnsafeUserProfile()
    private var isRunning = false
    
    @MainActor
    func runSimulation(logger: LogStore) async {
        logger.clear()
        corruptionDetected = false
        isRunning = true
        unsafeProfile.firstName = "Initial"
        unsafeProfile.lastName = "Name"
        currentDisplayedName = unsafeProfile.fullName
        
        logger.log("Starting simulation...", type: .action)
        logger.log("Target A: Alice Smith", type: .info)
        logger.log("Target B: Bob Jones", type: .info)
        
        // 1. The "Writer" Tasks
        // Launch competing tasks that violently update the profile simultaneously
        Task {
            while isRunning {
                // Competing Update A
                Task.detached { await self.unsafeProfile.updateProfile(newFirst: "Alice", newLast: "Smith", logger: logger) }
                // Competing Update B
                Task.detached { await self.unsafeProfile.updateProfile(newFirst: "Bob", newLast: "Jones", logger: logger) }
                // Brief pause to let them fight
                try? await Task.sleep(nanoseconds: 5_000_000)
            }
        }
        
        // 2. The "Reader" Task (The Observer)
        // This represents the UI trying to render the object
        // It repeatedly reads the state to see if it ever catches a corrupted value
        Task {
            while isRunning {
                let readName = unsafeProfile.fullName
                
                await MainActor.run {
                    self.currentDisplayedName = readName
                    
                    // DETECT CORRUPTION
                    // A valid state is either "Alice Smith" or "Bob Jones"
                    // Anything else means we read the object in the middle of an update.
                    if readName == "Alice Jones" || readName == "Bob Smith" {
                        self.corruptionDetected = true
                        logger.log("🚨 CORRUPTION DETECTED: Read inconsistent state: '\(readName)'", type: .error)
                        self.isRunning = false // Stop the madness
                    }
                }
                // Read very frequently
                try? await Task.sleep(nanoseconds: 1_000_000)
            }
        }
    }
    
    @MainActor
    func stop() {
        isRunning = false
    }
}
