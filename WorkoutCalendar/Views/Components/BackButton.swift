//
//  BackButton.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/12.
//

import SwiftUI

// MARK: - Back Button

struct BackButton: View {

    // MARK: - Properties

    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: Constants.SFSymbols.chevronLeft)
        }
    }
}

#Preview {
    BackButton { }
}
