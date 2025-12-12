//
//  WorkoutDetailViewModel.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation
import Observation

@Observable
@MainActor
final class WorkoutDetailViewModel {

    // MARK: - State Enum

    enum State {
        case loading
        case loaded(WorkoutMetadata, WorkoutDiagram)
        case error(String)
    }

    // MARK: - Properties

    let workout: Workout
    private(set) var state: State = .loading
    private let service: NetworkServiceProtocol

    // MARK: - Init

    convenience init() {
        self.init(
            workout: Workout.mock,
            service: MockDataService()
        )
    }

    init(workout: Workout, service: NetworkServiceProtocol) {
        self.workout = workout
        self.service = service
    }

    // MARK: - Public Methods

    func loadData() async {
        state = .loading

        do {
            let allMetadata = try await service.fetchMetadata()
            let allDiagrams = try await service.fetchDiagramData()

            guard
                let metadata = allMetadata[workout.workoutKey],
                let diagramData = allDiagrams[workout.workoutKey]
            else {
                state = .error("Data not found for this workout")
                return
            }

            state = .loaded(metadata, diagramData)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
