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
                Section(header: Text("The Fundamentals")) {
                    NavigationLink("The Locked Room (NSLock)") {
                        LockedRoomView(logger: logger)
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
    var WarningColor: Color = .blue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(WarningColor)
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
