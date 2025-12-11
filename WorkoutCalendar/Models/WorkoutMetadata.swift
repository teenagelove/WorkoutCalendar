//
//  WorkoutMetadata.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation

struct WorkoutMetadata: Decodable, Identifiable {
    let workoutKey: String
    let workoutActivityType: String
    let workoutStartDate: String
    let distance: String?
    let duration: String?
    let maxLayer: Int?
    let maxSubLayer: Int?
    let avg_humidity: String?
    let avg_temp: String?
    let comment: String?
    let photoBefore: String?
    let photoAfter: String?
    let heartRateGraph: String?
    let activityGraph: String?
    let map: String?
    
    var id: String { workoutKey }
}
