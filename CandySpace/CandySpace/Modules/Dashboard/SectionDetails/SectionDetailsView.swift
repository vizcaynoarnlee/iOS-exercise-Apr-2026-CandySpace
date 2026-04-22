//
//  SectionDetailsView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct SectionDetailsView: View {
    let viewModel: SectionDetailsViewModel

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 12, alignment: .top),
        GridItem(.flexible(), spacing: 12, alignment: .top),
    ]

    var body: some View {
        ScrollView {
            switch viewModel.layout {
            case .grid2Col:
                LazyVGrid(columns: gridColumns, spacing: 12) {
                    ForEach(viewModel.items) { itemViewModel in
                        ItemCardView(viewModel: itemViewModel)
                    }
                }
                .padding(.horizontal, 16)

            case .fullWidthRows:
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.items) { itemViewModel in
                        ItemCardView(viewModel: itemViewModel)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

