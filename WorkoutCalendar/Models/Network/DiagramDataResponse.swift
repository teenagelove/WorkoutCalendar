//
//  DiagramDataResponse.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

struct DiagramDataResponse: Decodable {
    let workouts: [String: WorkoutDiagram]
}
