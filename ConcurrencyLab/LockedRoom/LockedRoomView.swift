//
//  LockedRoomView.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//
import SwiftUI

struct LockedRoomView: View {
    var logger: LogStore
    @State private var viewModel = LockedCounterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ScenarioHeader(
                title: "Non-Reentrant & Thread-Safe",
                subtitle: "Classic NSLock. Safe, but blocks threads during critical sections."
            )
            
            Text("Final Count: \(viewModel.count)")
                .font(.title)
                .bold()
            
            Button("Simulate 10 Concurrent Threads") {
                viewModel.runSimulator(logger: logger)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            LoggerView(logger: logger)
                .frame(height: 250)
        }
        .padding()
    }
}
