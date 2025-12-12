//
//  WorkoutRowView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

// MARK: - Workout Row View

struct WorkoutRowView: View {
    
    // MARK: - Properties
    
    let workout: Workout
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.workoutActivityType)
                    .font(.appHeadline)
                
                if let date = workout.startDate {
                    Text(date.formatted(date: .omitted, time: .shortened))
                        .font(.appSubheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: Constants.SFSymbols.chevronRight)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    WorkoutRowView(workout: .mock)
}
