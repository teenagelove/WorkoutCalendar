//
//  CalendarScreenView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

struct CalendarScreenView: View {
    @Environment(Coordinator.self) private var coordinator
    @State private var viewModel = CalendarViewModel()
    
    var body: some View {
        NavigationStack(path: Bindable(coordinator).path) {
            content
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(for: AppDestination.self) { destination in
                    switch destination {
                    case .workoutDetail(let workout):
                        WorkoutDetailView(workout: workout)
                    }
                }
        }
        .task {
            await viewModel.loadWorkouts()
        }
    }
}

private extension CalendarScreenView {
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            LoadingView()
        case .loaded:
            loadedView
        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.loadWorkouts() }
            }
        }
    }
    
    var loadedView: some View {
        ScrollView {
            VStack(spacing: 24) {
                calendarSection
                Divider()
                workoutsListSection
            }
            .padding(.vertical)
        }
    }
    
    var calendarSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(.calendarTitle)
                .font(.largeTitle.bold())
                .foregroundStyle(.primary)
                .padding(.horizontal)
            
            CalendarView(
                markedDates: viewModel.markedDates,
                selectedDate: $viewModel.selectedDate,
                currentMonthStart: $viewModel.currentMonth
            )
            .padding(.horizontal)
        }
    }
    
    var workoutsListSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let selectedDate = viewModel.selectedDate {
                Text(selectedDate.weekdayName)
                    .font(.title2.bold())
                    .padding(.horizontal)
            }
            
            if viewModel.workoutsForSelectedDate.isEmpty {
                emptyState
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.workoutsForSelectedDate) { workout in
                        Button {
                            coordinator.navigate(to: .workoutDetail(workout))
                        } label: {
                            WorkoutRowView(workout: workout)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        
                        Divider()
                            .padding(.leading)
                    }
                }
            }
        }
    }
    
    var emptyState: some View {
        ContentUnavailableView(
            label: {
                Label(.emptyStateTitle, systemImage: SFSymbols.calendar)
            },
            description: {
                Text("No workouts for this day")
            }
        )
    }
}
