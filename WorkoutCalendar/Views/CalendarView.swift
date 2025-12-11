//
//  CalendarView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

struct CalendarView: View {
    let markedDates: Set<Date>
    @Binding var selectedDate: Date?
    @Binding var currentMonthStart: Date

    var body: some View {
        VStack(spacing: 8) {
            header
                .padding(.bottom, 8)
            weekdayLabels
            daysGrid
        }
    }
}

// TODO: Too complicated extension
private extension CalendarView {
    var header: some View {
        HStack {
            Button {
                shiftMonth(by: -1)
            } label: {
                Image(systemName: SFSymbols.chevronLeft)
                    .font(.headline)
            }
            .buttonStyle(.plain)

            Spacer()

            Text(currentMonthStart.monthAndYear)
                .font(.headline)

            Spacer()

            Button {
                shiftMonth(by: 1)
            } label: {
                Image(systemName: SFSymbols.chevronRight)
                    .font(.headline)
            }
            .buttonStyle(.plain)
        }
    }

    var weekdayLabels: some View {
        HStack(spacing: 0) {
            ForEach(currentMonthStart.weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    var daysGrid: some View {
        let days = currentMonthStart.calendarGridDays
        let rows = days.count / 7
        return VStack(spacing: 6) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { col in
                        let index = row * 7 + col
                        dayCell(days[index])
                            .frame(maxWidth: .infinity, minHeight: 36)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func dayCell(_ date: Date?) -> some View {
        if let date {
            let isSelected = selectedDate?.isSameDay(as: date) ?? false
            let isMarked = markedDates.contains(date.startOfDay)

            Button {
                selectedDate = isSelected ? nil : date
            } label: {
                VStack(spacing: 4) {
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
                            .font(.body)
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

    func shiftMonth(by offset: Int) {
        if let newMonthStart = currentMonthStart.byAddingMonths(offset)?.startOfMonth {
            currentMonthStart = newMonthStart
        }
    }
}

#Preview {
    let today = Date().startOfDay
    let marks = Set([today, today.byAddingDays(2)].compactMap { $0 })

    return CalendarView(
        markedDates: marks,
        selectedDate: .constant(Date()),
        currentMonthStart: .constant(Date().startOfMonth)
    )
}

