//
//  ErrorView.swift
//  WorkoutCalendar
//
//  Created by Danil Kazakov on 2025/12/11.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            image
            errorMessage
            actionButton
        }
    }
}

private extension ErrorView {
    var image: some View {
        Image(systemName: SFSymbols.triangle)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.orange)
    }

    var errorMessage: some View {
        Text(message)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.horizontal, 16)
    }

    var actionButton: some View {
        Button(role: .none, action: action) {
            Label(.errorButtonTitle, systemImage: SFSymbols.clockwise)
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
    }
}

#Preview {
    ErrorView(message: "Error Error Error") { }
}
