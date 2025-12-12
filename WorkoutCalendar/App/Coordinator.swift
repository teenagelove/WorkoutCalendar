//
//  Coordinator.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI
import Observation

// MARK: - Types
    
enum AppDestination: Hashable {
    case workoutDetail(Workout)
}

@Observable
final class Coordinator {
    
    // MARK: - Properties
    
    var path = NavigationPath()
    
    // MARK: - Public Methods
    
    func navigate(to destination: AppDestination) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
