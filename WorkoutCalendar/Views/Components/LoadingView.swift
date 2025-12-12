//
//  LoadingView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftfulLoadingIndicators
import SwiftUI

// MARK: - Loading View

struct LoadingView: View {

    // MARK: - Body

    var body: some View {
        LoadingIndicator(animation: .fiveLinesPulse, color: .accent)
    }
}

#Preview {
    LoadingView()
}
