//
//  DiagramData.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation

struct WorkoutDiagramContainer: Decodable {
    let description: String?
    let data: [WorkoutPoint]
}

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
