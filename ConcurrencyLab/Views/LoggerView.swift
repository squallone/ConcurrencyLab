//
//  LoggerView.swift
//  ConcurrencyLab
//
//  Created by Abdiel Soto on 1/21/26.
//
import SwiftUI

struct LoggerView: View {
    var logger: LogStore
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Execution Log")
                    .font(.headline)
                    .bold()
                Spacer()
                Button("Clear") { logger.clear() }
                    .font(.caption)
            }
            .padding(.horizontal)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(logger.logs) { log in
                            HStack {
                                Text(log.timestamp, style: .time)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text(log.message)
                                    .font(.caption)
                                    .foregroundStyle(log.type.color)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            .id(log.id)
                        }
                    }
                    .padding()
                }
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .onChange(of: logger.logs.count) { oldCount, newCount in
                    if let lastId = logger.logs.last?.id, newCount > oldCount, newCount > 0 {
                        withAnimation { proxy.scrollTo(lastId, anchor: .bottom) }
                    }
                }
            }
        }
    }
}


#Preview {
    LoggerView(logger: LogStore())
}

