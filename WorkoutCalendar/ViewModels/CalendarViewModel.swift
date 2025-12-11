//
//  CalendarViewModel.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation
import Observation

@Observable
final class CalendarViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([Workout])
        case error(String)
    }
    
    var state: State = .idle
    var selectedDate: Date?
    var currentMonth: Date = Date()
    
    var workoutsForSelectedDate: [Workout] {
        guard let selectedDate, case .loaded(let workouts) = state else { return [] }
        return workouts.filter { workout in
            guard let date = workout.startDate else { return false }
            return Calendar.current.isDate(date, inSameDayAs: selectedDate)
        }
    }
    
    var markedDates: Set<Date> {
        guard case .loaded(let workouts) = state else { return [] }
        let dates = workouts.compactMap { $0.startDate?.startOfDay }
        return Set(dates)
    }
    
    @MainActor
    func loadWorkouts() async {
        state = .loading
        do {
            try await Task.sleep(nanoseconds: 500_000_000)
            
            let workouts = try await MockDataService.shared.fetchWorkouts().sorted {
                ($0.startDate ?? Date.distantPast) > ($1.startDate ?? Date.distantPast)
            }
            state = .loaded(workouts)
            
            if let firstDate = workouts.first?.startDate {
                currentMonth = firstDate.startOfMonth
                if selectedDate == nil {
                    selectedDate = firstDate
                }
            } else {
                 selectedDate = Date()
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func changeMonth(_ value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newDate
        }
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
    }
}
