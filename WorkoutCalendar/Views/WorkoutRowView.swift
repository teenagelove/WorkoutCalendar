//
//  WorkoutRowView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

struct WorkoutRowView: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.workoutActivityType)
                    .font(.headline)
                
                if let date = workout.startDate {
                    Text(date.formatted(date: .omitted, time: .shortened))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: SFSymbols.chevronRight)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
    }
}
