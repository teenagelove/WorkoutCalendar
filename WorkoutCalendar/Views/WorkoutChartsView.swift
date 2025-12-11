//
//  WorkoutChartsView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI
import Charts

struct WorkoutChartsView: View {
    let data: [WorkoutPoint]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Heart Rate
            VStack(alignment: .leading, spacing: 8) {
                Text("Heart Rate")
                    .font(.headline)
                
                Chart(data, id: \.time_numeric) { point in
                    LineMark(
                        x: .value("Time", point.time_numeric),
                        y: .value("BPM", point.heartRate)
                    )
                    .foregroundStyle(.red)
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: .automatic(includesZero: false))
                .frame(height: 200)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            
            // Speed
            VStack(alignment: .leading, spacing: 8) {
                Text("Speed (km/h)")
                    .font(.headline)
                
                Chart(data, id: \.time_numeric) { point in
                    LineMark(
                        x: .value("Time", point.time_numeric),
                        y: .value("Speed", point.speed_kmh)
                    )
                    .foregroundStyle(.blue)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("Time", point.time_numeric),
                        y: .value("Speed", point.speed_kmh)
                    )
                    .foregroundStyle(.blue.opacity(0.1))
                    .interpolationMethod(.catmullRom)
                }
                .frame(height: 200)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}
