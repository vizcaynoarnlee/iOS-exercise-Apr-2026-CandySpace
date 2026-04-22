//
//  DashboardSkeletonView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct DashboardSkeletonView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    private enum Constants {
        static let sectionCount: Int = 3
        static let itemCount: Int = 5
        static let interSectionSpacing: CGFloat = 28
        static let headerSpacing: CGFloat = 12
        static let cardSpacing: CGFloat = 12
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 16

        static let cardHeight: CGFloat = 180
        static let cardCornerRadius: CGFloat = 12
        static let headerCornerRadius: CGFloat = 8
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Constants.interSectionSpacing) {
                ForEach(0..<Constants.sectionCount, id: \.self) { index in
                    skeletonSection(variantIndex: index)
                }
            }
            .padding(.vertical, Constants.verticalPadding)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(String(localized: "Loading..."))
    }

    private func skeletonSection(variantIndex: Int) -> some View {
        VStack(alignment: .leading, spacing: Constants.headerSpacing) {
            skeletonHeader

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: Constants.cardSpacing) {
                    ForEach(0..<Constants.itemCount, id: \.self) { itemIndex in
                        skeletonCard(aspectRatio: aspectRatio(for: variantIndex, itemIndex: itemIndex))
                            .frame(width: cardWidth(for: aspectRatio(for: variantIndex, itemIndex: itemIndex)))
                    }
                }
                .padding(.horizontal, Constants.horizontalPadding)
            }
        }
    }

    private var skeletonHeader: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            RoundedRectangle(cornerRadius: Constants.headerCornerRadius, style: .continuous)
                .fill(placeholderFill)
                .frame(width: 140, height: 18)
                .shimmer(highlightOpacity: shimmerHighlightOpacity)

            Spacer(minLength: 12)

            RoundedRectangle(cornerRadius: Constants.headerCornerRadius, style: .continuous)
                .fill(placeholderFill)
                .frame(width: 92, height: 14)
                .shimmer(highlightOpacity: shimmerHighlightOpacity)
        }
        .padding(.horizontal, Constants.horizontalPadding)
    }

    private func skeletonCard(aspectRatio: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: Constants.cardCornerRadius, style: .continuous)
            .fill(placeholderFill)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(detailFill)
                        .frame(width: 56, height: 14)

                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(detailFill)
                        .frame(width: 44, height: 14)
                }
                .padding(8)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 4)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.18), radius: 4, x: 0, y: 6)
            .shimmer(highlightOpacity: shimmerHighlightOpacity)
            .accessibilityHidden(true)
    }

    private var placeholderFill: Color {
        switch colorScheme {
        case .light:
            return Color(uiColor: .systemGray5)
        case .dark:
            return Color.white.opacity(0.08)
        @unknown default:
            return Color.white.opacity(0.08)
        }
    }

    private var detailFill: Color {
        switch colorScheme {
        case .light:
            return Color(uiColor: .systemGray4)
        case .dark:
            return Color.white.opacity(0.06)
        @unknown default:
            return Color.white.opacity(0.06)
        }
    }

    private var shimmerHighlightOpacity: Double {
        switch colorScheme {
        case .light:
            return 0.28
        case .dark:
            return 0.18
        @unknown default:
            return 0.18
        }
    }

    private func aspectRatio(for variantIndex: Int, itemIndex: Int) -> CGFloat {
        let variants: [CGFloat] = [(2.0 / 3.0), (16.0 / 9.0), (2.0 / 3.0)]
        let base: CGFloat = variants[variantIndex % variants.count]
        let jitter: CGFloat = itemIndex.isMultiple(of: 2) ? 0.0 : 0.03
        return max(0.01, base + jitter)
    }

    private func cardWidth(for aspectRatio: CGFloat) -> CGFloat {
        let clamped: CGFloat = max(0.01, aspectRatio)
        return Constants.cardHeight * clamped
    }
}

#Preview {
    DashboardSkeletonView()
        .preferredColorScheme(.dark)
}

#Preview {
    DashboardSkeletonView()
        .preferredColorScheme(.light)
}

