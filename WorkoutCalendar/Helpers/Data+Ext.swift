//
//  Data+Ext.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import Foundation

extension Date {

    var isToday: Bool { Calendar.current.isDateInToday(self) }

    /// Returns the day component (1-31)
    var day: Int { Calendar.current.component(.day, from: self) }

    /// Returns the start of the day for the date.
    var startOfDay: Date { Calendar.current.startOfDay(for: self) }

    var weekdayName: String { formatted(.dateTime.weekday(.wide)) }

    /// Returns a formatted string for the month and year (e.g., "October 2025").
    var monthAndYear: String { formatted(.dateTime.month(.wide).year()).capitalized }

    /// Returns the start of the month for the date.
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components) ?? self.startOfDay
    }

    /// Returns weekday symbols ordered by calendar's first weekday
    var weekdaySymbols: [String] {
        let calendar = Calendar.current
        var symbols = calendar.shortStandaloneWeekdaySymbols
        let firstWeekday = calendar.firstWeekday - 1

        if firstWeekday > 0 {
            symbols = Array(symbols[firstWeekday...] + symbols[..<firstWeekday])
        }

        return symbols
    }

    /// Generates a grid of days for the month of the current date,
    /// including leading and trailing `nil` values to complete a 7-day week grid.
    var calendarGridDays: [Date?] {
        let calendar = Calendar.current
        var grid: [Date?] = []
        guard let range = calendar.range(of: .day, in: .month, for: self) else { return [] }

        let firstWeekdayOfMonth = calendar.component(.weekday, from: self) // 1...7
        let first = calendar.firstWeekday // 1...7 (e.g., 1 for Sunday, 2 for Monday)
        let leadingEmpty = (firstWeekdayOfMonth - first + 7) % 7

        // Leading nil values
        grid.append(contentsOf: Array(repeating: nil, count: leadingEmpty))

        // Days of the month
        for day in range {
            var comps = calendar.dateComponents([.year, .month], from: self)
            comps.day = day
            guard let date = calendar.date(from: comps) else { return [] }
            grid.append(date)
        }

        // Trailing nil values to complete rows of 7
        let remainder = grid.count % 7
        if remainder != 0 {
            grid.append(contentsOf: Array(repeating: nil, count: 7 - remainder))
        }

        return grid
    }
}

// MARK: - Date Calculations
extension Date {
    /// Checks if this date is on the same day as another date
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    /// Returns a new date by adding the specified number of months
    func byAddingMonths(_ months: Int) -> Date? {
        Calendar.current.date(byAdding: .month, value: months, to: self)
    }

    /// Returns a new date by adding the specified number of days
    func byAddingDays(_ days: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: days, to: self)
    }
}
