//
//  CalendarView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

// MARK: - Calendar View

struct CalendarView: View {
    
    // MARK: - Properties
    
    let markedDates: Set<Date>
    @Binding var selectedDate: Date

    let currentMonthStart: Date
    let onMonthChange: (Int) -> Void

    // MARK: - Body
    
    var body: some View {
        VStack {
            header
                .padding()
            weekdayLabels
            daysGrid
        }
    }
}

private extension CalendarView {
    
    // MARK: - UI Components
    
    var header: some View {
        HStack {
            Button {
                onMonthChange(-1)
            } label: {
                Image(systemName: Constants.SFSymbols.chevronLeft)
                    .font(.appHeadline)
            }
            .buttonStyle(.plain)

            Spacer()

            Text(currentMonthStart.monthAndYear)
                .font(.appHeadline)

            Spacer()

            Button {
                onMonthChange(1)
            } label: {
                Image(systemName: Constants.SFSymbols.chevronRight)
                    .font(.appHeadline)
            }
            .buttonStyle(.plain)
        }
    }

    var weekdayLabels: some View {
        HStack(spacing: 0) {
            ForEach(currentMonthStart.weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.appCaption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    var daysGrid: some View {
        let days = currentMonthStart.calendarGridDays
        let rows = days.count / 7

        return VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<7, id: \.self) { col in
                        let index = row * 7 + col
                        dayCell(days[index])
                            .frame(minWidth: 44, minHeight: 44)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func dayCell(_ date: Date?) -> some View {
        if let date {
            let isSelected = selectedDate.isSameDay(as: date)
            let isMarked = markedDates.contains(date.startOfDay)

            Button {
                selectedDate = isSelected ? Date() : date
            } label: {
                VStack {
                    ZStack {
                        if isSelected {
                            Circle()
                                .fill(Color.accentColor.opacity(0.8))
                                .frame(width: 44, height: 44)
                        }

                        if date.isToday {
                            Circle()
                                .fill(Color.accentColor.opacity(0.2))
                                .frame(width: 44, height: 44)
                        }

                        Text("\(date.day)")
                            .font(.bodyText)
                            .fontWeight(isSelected ? .semibold : .regular)
                            .foregroundStyle(.primary)
                    }

                    // Dot marker
                    Circle()
                        .fill(isMarked ? Color.accentColor : Color.clear)
                        .frame(width: 6, height: 6)
                        .opacity(isMarked ? 1.0 : 0.0)
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
            }
            .buttonStyle(.plain)
        } else {
            Color.clear.frame(height: 44)
        }
    }
}

#Preview {
    let today = Date().startOfDay
    let marks = Set([today, today.byAddingDays(2)].compactMap { $0 })

    return CalendarView(
        markedDates: marks,
        selectedDate: .constant(Date()),

        currentMonthStart: Date().startOfMonth,
        onMonthChange: { _ in }
    )
}

