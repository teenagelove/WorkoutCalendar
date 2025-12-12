//
//  WorkoutDiagram+Mock.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/12.
//

extension WorkoutDiagram {
    static let mock = WorkoutDiagram(
        description: "Morning Run",
        data: [
            WorkoutPoint(
                time_numeric: 0,
                heartRate: 80,
                speed_kmh: 0.0,
                distanceMeters: 0,
                steps: 0,
                elevation: 5.0,
                latitude: 37.7749,
                longitude: -122.4194,
                temperatureCelsius: 15.0,
                currentTimestamp: "2025-12-12T07:00:00Z"
            ),
            WorkoutPoint(
                time_numeric: 60,
                heartRate: 120,
                speed_kmh: 8.0,
                distanceMeters: 133,
                steps: 160,
                elevation: 7.0,
                latitude: 37.7750,
                longitude: -122.4195,
                temperatureCelsius: 15.5,
                currentTimestamp: "2025-12-12T07:01:00Z"
            ),
            WorkoutPoint(
                time_numeric: 120,
                heartRate: 140,
                speed_kmh: 10.0,
                distanceMeters: 333,
                steps: 400,
                elevation: 10.0,
                latitude: 37.7751,
                longitude: -122.4196,
                temperatureCelsius: 16.0,
                currentTimestamp: "2025-12-12T07:02:00Z"
            )
        ]
    )
}
