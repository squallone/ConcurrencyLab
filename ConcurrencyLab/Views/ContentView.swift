//
//  ContentView.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/19/26.
//

import SwiftUI

struct ContentView: View {
    @State private var logger = LogStore()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("The fundamentals")) {
                    NavigationLink("The locked room (NSLock)") {
                        LockedRoomView(logger: logger)
                    }
                    
                    NavigationLink("The Danger zone (Unsafe Class)") {
                        DangerZoneView(logger: logger)
                    }
                }
                
                Section(header: Text("The problem")) {
                    NavigationLink("The Reentrancy Trap (Actor Bug)") {
                        ReentrancyTrapView(logger: logger)
                    }
                }
                
                Section(header: Text("The solutions")) {
                    NavigationLink("Solution 1 - Check-wait-recheck") {
                        //SolutionView(solutionType: .checkRecheck, logger: logger)
                    }
                    
                    NavigationLink("Solution 2 - State Machine Lock") {
                        //SolutionView(solutionType: .stateMachine, logger: logger)
                    }
                    
                    NavigationLink("Solution 3: Functional Core") {
                        //SolutionView(solutionType: .functional, logger: logger)
                    }
                }
            }
            .navigationTitle("Concurrency Lab")
        }
    }
}





struct ScenarioHeader: View {
    let title: String
    let subtitle: String
    var warningColor: Color = .blue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(warningColor)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
        }
    }
}

#Preview {
    ContentView()
}
