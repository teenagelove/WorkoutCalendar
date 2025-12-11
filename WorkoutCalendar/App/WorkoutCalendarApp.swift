//
//  WorkoutCalendarApp.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

@main
struct WorkoutCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            CalendarScreenView()
                .environment(Coordinator())
        }
    }
}
