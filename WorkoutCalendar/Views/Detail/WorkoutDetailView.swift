//
//  WorkoutDetailView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

// MARK: - Workout Detail View

struct WorkoutDetailView: View {
    
    // MARK: - State
    
    @State private var viewModel: WorkoutDetailViewModel
    
    // MARK: - Dependencies
    
    @Environment(Coordinator.self) private var coordinator

    // MARK: - Init

    init() {
        self.init(workout: Workout.mock, service: MockDataService())
    }

    init(workout: Workout, service: NetworkServiceProtocol) {
        _viewModel = State(initialValue: WorkoutDetailViewModel(workout: workout, service: service))
    }

    // MARK: - Body

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .loaded(let metadata, let diagramData):
                content(metadata: metadata, diagramData: diagramData)
            case .error(let message):
                ErrorView(message: message) {
                    Task { await viewModel.loadData() }
                }
            }
        }
        .navigationTitle(viewModel.workout.workoutActivityType)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton { coordinator.pop() }
            }
        }
        .task { await viewModel.loadData() }
    }
}

private extension WorkoutDetailView {
    
    // MARK: - UI Components
    
    func content(metadata: WorkoutMetadata, diagramData: WorkoutDiagram) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                headerInfo(metadata: metadata)

                statsGrid(metadata: metadata)

                WorkoutChartsView(data: diagramData.data)
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
    }

    func headerInfo(metadata: WorkoutMetadata?) -> some View {
        VStack {
            if let date = viewModel.workout.startDate {
                Text(date.formatted(date: .long, time: .shortened))
                    .font(.appTitle3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let comment = metadata?.comment {
                Text(comment)
                    .font(.bodyText)
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }

    func statsGrid(metadata: WorkoutMetadata) -> some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns) {
            if let dist = metadata.distance {
                statBox(
                    title: String(localized: .distanceTitle),
                    value: "\(dist) m",
                    icon: Constants.SFSymbols.figureRun
                )
            }

            if let dur = metadata.duration {
                statBox(
                    title: String(localized: .durationTitle),
                    value: "\(dur) sec",
                    icon: Constants.SFSymbols.clock
                )
            }

            if let temp = metadata.avg_temp {
                statBox(
                    title: String(localized: .tempTitle),
                    value: "\(temp) °C",
                    icon: Constants.SFSymbols.thermometer
                )
            }

            if let humidity = metadata.avg_humidity {
                statBox(
                    title: String(localized: .humidityTitle),
                    value: "\(humidity) %",
                    icon: Constants.SFSymbols.humidity
                )
            }
        }
        .padding(.horizontal)
    }

    func statBox(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Label(title, systemImage: icon)
                .font(.appCaption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.appHeadline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        WorkoutDetailView()
    }
}
