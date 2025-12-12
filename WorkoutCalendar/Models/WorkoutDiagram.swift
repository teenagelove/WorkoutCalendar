//
//  WorkoutDiagram.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/12.
//

struct WorkoutDiagram: Decodable {
    let description: String?
    let data: [WorkoutPoint]
}
