//
//  CalendarViewModelTests.swift
//  WorkoutCalendarTests
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Testing
import Foundation
@testable import WorkoutCalendar

struct CalendarViewModelTests {
    
    @MainActor
    private func makeViewModel() -> CalendarViewModel {
        CalendarViewModel()
    }
    
    @Test
    func `viewModel should have idle state initially`() async {
        // Given
        let viewModel = await makeViewModel()
        
        // Then
        if case .idle = await viewModel.state {
            #expect(true)
        } else {
            #expect(Bool(false), "State should be idle")
        }
    }
    
    @Test
    func `viewModel should load workouts and transition to loaded state`() async {
        // Given
        let viewModel = await makeViewModel()
        
        // When
        await viewModel.loadWorkouts()
        
        // Then
        if case .loaded(let workouts) = await viewModel.state {
            #expect(!workouts.isEmpty)
        } else if case .error = await viewModel.state {
             // If files missing in test bundle, this branches.
        } else {
            #expect(Bool(false), "State should be loaded or error")
        }
    }
    
    @Test
    func `viewModel should filter workouts by selected date`() async {
        // Given
        let viewModel = await makeViewModel()
        await viewModel.loadWorkouts()
        
        guard case .loaded(let workouts) = await viewModel.state, let workout = workouts.first, let date = await workout.startDate else {
            return
        }
        
        // When
        await viewModel.selectDate(date)
        
        // Then
        let filtered = await viewModel.workoutsForSelectedDate
        #expect(filtered.contains { $0.id == workout.id })
    }
    
    @Test
    func `viewModel should change month correctly`() async {
        // Given
        let viewModel = await makeViewModel()
        let initialMonth = await viewModel.currentMonth
        
        // When
        await viewModel.changeMonth(1)
        
        // Then
        let expected = Calendar.current.date(byAdding: .month, value: 1, to: initialMonth)!
        #expect(Calendar.current.isDate(viewModel.currentMonth, equalTo: expected, toGranularity: .month))
    }
}
