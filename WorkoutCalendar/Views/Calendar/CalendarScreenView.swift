//
//  CalendarScreenView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

// MARK: - Calendar Screen View

struct CalendarScreenView: View {
    
    // MARK: - Dependencies
    
    @Environment(Coordinator.self) private var coordinator
    
    // MARK: - State
    
    @State private var viewModel: CalendarViewModel

    // MARK: - Init

    init() {
        _viewModel = State(initialValue: CalendarViewModel())
    }

    init(service: NetworkServiceProtocol) {
        _viewModel = State(initialValue: CalendarViewModel(service: service))
    }

    // MARK: - Body
    
    var body: some View {
        content
            .navigationTitle(.calendarTitle)
            .task { await viewModel.loadWorkouts() }
    }
}

private extension CalendarScreenView {

    // MARK: - UI Components

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
        List {
            calendarSection
            workoutsListSection
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }

    var calendarSection: some View {
        CalendarView(
            markedDates: viewModel.markedDates,
            selectedDate: $viewModel.selectedDate,
            currentMonthStart: viewModel.currentMonth,
            onMonthChange: { offset in
                viewModel.shiftMonth(by: offset)
            }
        )
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }

    var workoutsListSection: some View {
        Section {
            if viewModel.workoutsForSelectedDate.isEmpty {
                EmptyStateView()
            } else {
                ForEach(viewModel.workoutsForSelectedDate) { workout in
                    workoutRow(for: workout)
                }
            }
        } header: {
            sectionHeader
        }
        .listRowSeparator(.hidden)
    }

    func workoutRow(for workout: Workout) -> some View {
        Button {
            coordinator.navigate(to: .workoutDetail(workout))
        } label: {
            WorkoutRowView(workout: workout)
                .padding()
                .background(.background)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .primary.opacity(0.5), radius: 4)
        }
        .buttonStyle(.plain)
    }

    var sectionHeader: some View {
        VStack(alignment: .leading) {
            Text(viewModel.selectedDate.weekdayName)
                .font(.title2Bold)
        }
    }
}

#Preview {
    NavigationStack {
        CalendarScreenView()
    }
}
