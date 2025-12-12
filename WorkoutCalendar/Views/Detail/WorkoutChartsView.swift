//
//  WorkoutChartsView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI
import Charts

// MARK: - Workout Charts View

struct WorkoutChartsView: View {
    
    // MARK: - Properties
    
    let data: [WorkoutPoint]
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Heart Rate
            VStack(alignment: .leading, spacing: 8) {
                Text(.heartrateTitle)
                    .font(.appHeadline)
                
                Chart(data, id: \.time_numeric) { point in
                    LineMark(
                        x: .value(.timeTitle, point.time_numeric),
                        y: .value(.bpmTitle, point.heartRate)
                    )
                    .foregroundStyle(.red)
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: .automatic(includesZero: false))
                .frame(height: 200)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Speed
            VStack(alignment: .leading, spacing: 8) {
                Text(.speedKmTitle)
                    .font(.appHeadline)
                
                Chart(data, id: \.time_numeric) { point in
                    LineMark(
                        x: .value(.timeTitle, point.time_numeric),
                        y: .value(.speedTitle, point.speed_kmh)
                    )
                    .foregroundStyle(.blue)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value(.timeTitle, point.time_numeric),
                        y: .value(.speedTitle, point.speed_kmh)
                    )
                    .foregroundStyle(.blue.opacity(0.1))
                    .interpolationMethod(.catmullRom)
                }
                .frame(height: 200)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    WorkoutChartsView(data: WorkoutDiagram.mock.data)
}
