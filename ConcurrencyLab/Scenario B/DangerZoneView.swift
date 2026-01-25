//
//  DangerZoneView.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/24/26.
//

import Foundation
import SwiftUI

struct DangerZoneView: View {
    var logger: LogStore
    private let viewModel = DangerZoneViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ScenarioHeader(
                title: "Reentrant & NOT Thread-Safe",
                subtitle: "Standard class with async methods. Simulating simultaneous multi-step updates.",
                warningColor: .red
            )
            
            VStack(spacing: 10) {
                Text("UI Read State:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(viewModel.currentDisplayedName)
                    .font(.title)
                    .bold()
                    .padding()
                    .background(viewModel.corruptionDetected ? Color.red.opacity(0.2) : Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            if viewModel.corruptionDetected {
                Text("🚨 INCONSISTENT STATE READ! 🚨")
                    .font(.headline)
                    .foregroundColor(.red)
                Text("The UI read the object while it was paused halfway through an update, resulting in a mix of data (e.g., Alice's first name with Bob's last name).")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            HStack {
                Button("Start 'Frankenset' Attack") {
                    Task { await viewModel.runSimulation(logger: logger) }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button("Stop") {
                    viewModel.stop()
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.corruptionDetected)
            }
            
            Spacer()
            
            LoggerView(logger: logger)
        }
        .padding()
    }
}

#Preview {
    DangerZoneView(logger: LogStore())
}
