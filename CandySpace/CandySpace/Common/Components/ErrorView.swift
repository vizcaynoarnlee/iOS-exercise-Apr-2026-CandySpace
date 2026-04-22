//
//  ErrorView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//


import SwiftUI

struct ErrorView: View {
    var errorMessage: String?
    var onRefresh: (() -> Void)?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.largeTitle)
            Text(errorMessage ?? String(localized: "Unknown error occurred."))
                .font(.caption)

            if let onRefresh {
                Button(String(localized: "Retry"), action: onRefresh)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ErrorView()
}
