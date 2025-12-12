//
//  MockDataServiceTests.swift
//  WorkoutCalendarTests
//
//  Created by Danil Kazakov on 2025/12/12.
//

import Testing
import Foundation
@testable import WorkoutCalendar

struct MockDataServiceTests {
    
    private let service: NetworkServiceProtocol
    
    init() {
        self.service = MockDataService()
    }
    
    @Test
    func `service should fetch workouts successfully`() async throws {
        // Given
        // Service initialized
        
        // When
        let workouts = try await service.fetchWorkouts()
        
        // Then
        #expect(!workouts.isEmpty)
    }
    
    @Test
    func `service should fetch metadata successfully`() async throws {
        // Given
        // Service initialized
        
        // When
        let metadata = try await service.fetchMetadata()
        
        // Then
        #expect(!metadata.isEmpty)
    }
    
    @Test
    func `service should fetch diagram data successfully`() async throws {
        // Given
        // Service initialized
        
        // When
        let diagrams = try await service.fetchDiagramData()
        
        // Then
        #expect(!diagrams.isEmpty)
    }
}
