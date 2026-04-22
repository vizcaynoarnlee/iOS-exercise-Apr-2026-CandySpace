//
//  SectionRailView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct SectionRailView: View {
    let viewModel: SectionRailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(viewModel.visibleItems) { itemViewModel in
                        ItemCardView(viewModel: itemViewModel)
                            .frame(width: itemWidth(for: itemViewModel.aspectRatio))
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(viewModel.title)
                .font(.headline)

            Spacer(minLength: 12)

            Button(viewModel.viewAllTitle, action: viewModel.onViewAllTap)
                .font(.subheadline.weight(.semibold))
                .disabled(viewModel.canViewAll == false)
        }
        .padding(.horizontal, 16)
    }

    private func itemWidth(for aspectRatio: CGFloat) -> CGFloat {
        let clamped: CGFloat = max(0.01, aspectRatio)
        let height: CGFloat = 180
        return height * clamped
    }
}

