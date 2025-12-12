//
//  Workout.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation

struct Workout: Decodable, Identifiable, Hashable {
    let workoutKey: String
    let workoutActivityType: String
    let workoutStartDate: String
    
    var id: String { workoutKey }

    var startDate: Date? {
        workoutStartDate.toDate
    }
}
