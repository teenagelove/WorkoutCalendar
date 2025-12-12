//
//  NetworkServiceProtocol.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/12.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchWorkouts() async throws -> [Workout]
    func fetchMetadata() async throws -> [String: WorkoutMetadata]
    func fetchDiagramData() async throws -> [String: WorkoutDiagram]
}
