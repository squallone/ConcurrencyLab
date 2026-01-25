//
//  UnsafeInventory.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//

import Foundation

// SCENARIO B: The Danger Zone ("The Frankenset")
// Quadrant: Reentrant & NOT Thread-Safe

/// A standard class with mutable state. No Actor, no Locks
class UnsafeUserProfile {
    var firstName = "Initial"
    var lastName = "Name"
    
    // An async method that mutates state in multiple steps.
    func updateProfile(newFirst: String, newLast: String, logger: LogStore) async {
        logger.log("Starting profile update for \(newFirst) \(newLast)")
        // STEP 1: Update part of the state
        firstName = newFirst

        // CRITICAL SUSPENSION POINT
        // Because this is a standard class, nothing stops another thread
        // from reading or writing the state right now while we are paused
        // The object is currently in an INCONSISTENT STATE (New First Name + Old Last Name)
        try? await Task.sleep(nanoseconds: 10_000_000) // Sleep 10ms

        // STEP 2: Update the rest of the state
        lastName = newLast
        logger.log("Profile updated to \(fullName)")
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
