//
//  ErrorView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//


import SwiftUI

struct ErrorView: View {
    var errorMessage: String?

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.largeTitle)
            Text(errorMessage ?? "Unknown error occurred.")
                .font(.caption)
        }
    }
}

#Preview {
    ErrorView()
}
