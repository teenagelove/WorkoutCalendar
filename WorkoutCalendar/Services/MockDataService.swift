//
//  MockDataService.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation

enum MockDataError: Error {
    case fileNotFound(String)
    case dataCorrupted
}

final class MockDataService {
    static let shared = MockDataService()
    
    private init() {}
    
    func fetchWorkouts() async throws -> [Workout] {
        let response: WorkoutListResponse = try loadJSON(filename: "list_workouts")
        return response.data
    }
    
    func fetchMetadata() async throws -> [String: WorkoutMetadata] {
        let response: MetadataResponse = try loadJSON(filename: "metadata")
        return response.workouts
    }
    
    func fetchDiagramData() async throws -> [String: WorkoutDiagramContainer] {
        let response: DiagramDataResponse = try loadJSON(filename: "diagram_data")
        return response.workouts
    }
}

private extension MockDataService {
    func loadJSON<T: Decodable>(filename: String) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw MockDataError.fileNotFound(filename)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
}
