//
//  LoadingView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftfulLoadingIndicators
import SwiftUI

struct LoadingView: View {
    var body: some View {
        LoadingIndicator(animation: .fiveLinesPulse, color: .accent)
    }
}

#Preview {
    LoadingView()
}
