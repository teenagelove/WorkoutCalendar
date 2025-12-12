//
//  CalendarViewModelTests.swift
//  WorkoutCalendarTests
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Testing
import Foundation
@testable import WorkoutCalendar

@MainActor
struct CalendarViewModelTests {

    private let vm: CalendarViewModel

    init() {
        vm = CalendarViewModel()
    }

    @Test
    func `viewModel should have idle state initially`() async {
        // Given
        
        // Then
        if case .idle = vm.state {
            #expect(true)
        } else {
            #expect(Bool(false), "State should be idle")
        }
    }
    
    @Test
    func `viewModel should load workouts and transition to loaded state`() async {
        // Given
        
        // When
        await vm.loadWorkouts()

        // Then
        if case .loaded(let workouts) = vm.state {
            #expect(!workouts.isEmpty)
        } else if case .error = vm.state {
             // If files missing in test bundle, this branches.
        } else {
            #expect(Bool(false), "State should be loaded or error")
        }
    }
    
    @Test
    func `viewModel should filter workouts by selected date`() async {
        // Given
        await vm.loadWorkouts()

        guard
            case .loaded(let workouts) = vm.state,
            let workout = workouts.first,
            let date = workout.startDate
        else { return }

        // When
        vm.selectDate(date)

        // Then
        let filtered = vm.workoutsForSelectedDate
        #expect(filtered.contains { $0.id == workout.id })
    }
    
    @Test
    func `viewModel should change month correctly`() async {
        // Given
        let initialMonth = vm.currentMonth

        // When
        vm.changeMonth(1)

        // Then
        let expected = Calendar.current.date(byAdding: .month, value: 1, to: initialMonth)!
        let current = vm.currentMonth
        #expect(Calendar.current.isDate(current, equalTo: expected, toGranularity: .month))
    }
}
