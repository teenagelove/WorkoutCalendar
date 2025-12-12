//
//  CalendarViewModel.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation
import Observation

@Observable
@MainActor
final class CalendarViewModel {

    // MARK: - State Enum

    enum State {
        case idle
        case loading
        case loaded([Workout])
        case error(String)
    }

    // MARK: - Properties

    var selectedDate = Date()
    var currentMonth = Date().startOfMonth
    private(set) var state: State = .idle
    private let service: NetworkServiceProtocol

    // MARK: - Init
    
    convenience init() {
        self.init(service: MockDataService())
    }

    init(service: NetworkServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func loadWorkouts() async {
        state = .loading

        do {
            let workouts = try await service.fetchWorkouts()
            state = .loaded(workouts)

        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func selectDate(_ date: Date) {
        selectedDate = date
    }

    func shiftMonth(by offset: Int) {
        if let newMonth = currentMonth.byAddingMonths(offset)?.startOfMonth {
            currentMonth = newMonth
        }
    }
}

// MARK: - Derived Data
extension CalendarViewModel {

    var workoutsForSelectedDate: [Workout] {
        guard case .loaded(let workouts) = state else { return [] }

        return workouts
            .filter { $0.startDate?.isSameDay(as: selectedDate) == true }
            .sorted { ($0.startDate ?? .distantPast) < ($1.startDate ?? .distantPast) }
    }

    var markedDates: Set<Date> {
        guard case .loaded(let workouts) = state else { return [] }

        let dates = workouts.compactMap { $0.startDate?.startOfDay }
        return Set(dates)
    }
}
