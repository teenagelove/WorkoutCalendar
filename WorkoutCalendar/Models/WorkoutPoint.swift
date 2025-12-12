//
//  WorkoutPoint.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

struct WorkoutPoint: Decodable, Hashable {
    let time_numeric: Int
    let heartRate: Int
    let speed_kmh: Double
    let distanceMeters: Int
    let steps: Int
    let elevation: Double
    let latitude: Double
    let longitude: Double
    let temperatureCelsius: Double
    let currentTimestamp: String
}
