//
//  WorkoutCalendarApp.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

@main
struct WorkoutCalendarApp: App {
    // MARK: - State
    
    @State private var coordinator = Coordinator()
    private let networkService = MockDataService()
    
    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                CalendarScreenView(service: networkService)
                    .navigationDestination(for: AppDestination.self) { destination in
                        switch destination {
                        case .workoutDetail(let workout):
                            WorkoutDetailView(workout: workout, service: networkService)
                        }
                    }
            }
            .environment(coordinator)
        }
    }
}
