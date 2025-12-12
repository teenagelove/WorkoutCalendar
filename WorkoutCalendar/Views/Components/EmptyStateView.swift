//
//  EmptyStateView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/12.
//

import SwiftUI

// MARK: - Empty State View

struct EmptyStateView: View {
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            EmptyLottieView()

            Text(.emptyStateTitle)
                .font(.appHeadline)
                .foregroundColor(.gray)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 80)
    }
}

#Preview {
    EmptyStateView()
}
