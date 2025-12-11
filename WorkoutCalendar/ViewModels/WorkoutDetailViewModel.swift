//
//  WorkoutDetailViewModel.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation
import Observation

@Observable
final class WorkoutDetailViewModel {
    
    enum State {
        case loading
        case loaded(WorkoutMetadata, WorkoutDiagramContainer)
        case error(String)
    }
    
    var state: State = .loading
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    @MainActor
    func loadData() async {
        state = .loading
        do {
            try await Task.sleep(nanoseconds: 300_000_000)
            
            let allMetadata = try await MockDataService.shared.fetchMetadata()
            let allDiagrams = try await MockDataService.shared.fetchDiagramData()
            
            guard let metadata = allMetadata[workout.workoutKey],
                  let diagramData = allDiagrams[workout.workoutKey] else {
                state = .error("Data not found for this workout")
                return
            }
            
            state = .loaded(metadata, diagramData)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
