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

final class MockDataService: NetworkServiceProtocol {

    // MARK: - Public Methods
    
    func fetchWorkouts() async throws -> [Workout] {
        try await simulateDelay()
        let response: WorkoutListResponse = try loadJSON(filename: "list_workouts")
        return response.data
    }
    
    func fetchMetadata() async throws -> [String: WorkoutMetadata] {
        try await simulateDelay()
        let response: MetadataResponse = try loadJSON(filename: "metadata")
        return response.workouts
    }
    
    func fetchDiagramData() async throws -> [String: WorkoutDiagram] {
        try await simulateDelay()
        let response: DiagramDataResponse = try loadJSON(filename: "diagram_data")
        return response.workouts
    }
}

// MARK: - Private Methods

private extension MockDataService {
    func simulateDelay() async throws {
        try await Task.sleep(for: .seconds(3))
    }

    func loadJSON<T: Decodable>(filename: String) throws -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw MockDataError.fileNotFound(filename)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
}
