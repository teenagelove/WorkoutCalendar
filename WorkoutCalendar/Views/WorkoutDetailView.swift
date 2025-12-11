//
//  WorkoutDetailView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State private var viewModel: WorkoutDetailViewModel
    @Environment(Coordinator.self) private var coordinator
    
    init(workout: Workout) {
        _viewModel = State(initialValue: WorkoutDetailViewModel(workout: workout))
    }
    
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
        .task {
            await viewModel.loadData()
        }
        .navigationTitle(viewModel.workout.workoutActivityType)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.pop()
                } label: {
                    Image(systemName: SFSymbols.chevronLeft)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private extension WorkoutDetailView {
    func content(metadata: WorkoutMetadata, diagramData: WorkoutDiagramContainer) -> some View {
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
        VStack(spacing: 16) {
            Text(viewModel.workout.workoutActivityType)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let date = viewModel.workout.startDate {
                Text(date.formatted(date: .long, time: .shortened))
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if let comment = metadata?.comment {
                Text(comment)
                    .font(.body)
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }

    func statsGrid(metadata: WorkoutMetadata) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            if let dist = metadata.distance {
                statBox(title: "Distance", value: "\(dist) m", icon: "figure.run")
            }
            if let dur = metadata.duration {
                statBox(title: "Duration", value: "\(dur) sec", icon: "clock")
            }
            if let temp = metadata.avg_temp {
                statBox(title: "Temp", value: "\(temp) °C", icon: "thermometer")
            }
            if let humidity = metadata.avg_humidity {
                statBox(title: "Humidity", value: "\(humidity) %", icon: "humidity")
            }
        }
        .padding(.horizontal)
    }

    
    func statBox(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
