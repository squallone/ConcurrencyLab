//
//  ReentrancyTrapView.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/24/26.
//

import Foundation
import SwiftUI

struct ReentrancyTrapView: View {
    var logger: LogStore
    private let viewModel = ReentrancyTrapViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ScenarioHeader(
                title: "The reentrancy trap",
                subtitle: "Actor is thread-safe, but state changes during 'await'",
                warningColor: .orange
            )
            
            HStack {
                Text("Initial stock 1")
                Spacer()
                Text("Final Stock: \(viewModel.finalStock)")
                    .bold()
                    .foregroundStyle(viewModel.finalStock < 0 ? .red : .green)
            }
            .font(.title3)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(12)
            
            if viewModel.finalStock < 0 {
                Text("Bug: Stock dropped below zero! We oversold")
                    .foregroundColor(.red)
                    .bold()
            }
            
            Button("Simulate double buy (Alice & Bob)") {
                viewModel.runSimulation(logger: logger)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            
            Spacer()
            
            LoggerView(logger: logger)
        }
        .padding()
    }
}

#Preview {
    ReentrancyTrapView(logger: LogStore())
}
