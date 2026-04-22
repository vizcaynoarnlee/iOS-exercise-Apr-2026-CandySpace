//
//  ItemCardView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct ItemCardView: View {
    let viewModel: ItemCardViewModel

    var body: some View {
        Button(action: viewModel.onTap) {
            ZStack(alignment: .topLeading) {
                RemoteImageView(url: viewModel.imageURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()

                overlays
            }
            .aspectRatio(viewModel.aspectRatio, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.25), radius: 4, x: 0, y: 6)
        .accessibilityLabel(viewModel.accessibilityLabel ?? "")
    }

    @ViewBuilder
    private var overlays: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let badgeText = viewModel.badgeText, badgeText.isEmpty == false {
                overlayLabel(text: badgeText)
            }

            if let tierText = viewModel.tierText, tierText.isEmpty == false {
                overlayLabel(text: tierText)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    private func overlayLabel(text: String) -> some View {
        Text(text)
            .font(.caption2.weight(.semibold))
            .foregroundStyle(Color(uiColor: .label))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(uiColor: .systemBackground).opacity(0.85))
            .clipShape(Capsule())
    }
}

