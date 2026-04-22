//
//  DashboardView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct DashboardView: View {
    @State var viewModel: DashboardViewModel = .init()

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .initial, .loading:
                    ProgressView(String(localized: "Loading..."))

                case .loaded:
                    contentView

                case let .error(error):
                    ErrorView(errorMessage: error.localizedDescription)
                }
            }
            .task {
                if viewModel.viewState == .initial {
                    await viewModel.loadMedia()
                }
            }
        }
    }

    var contentView: some View {
        ZStack {
            if viewModel.isSectionsEmpty {
                EmptyStateView(message: String(localized: "No media found."))
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 28) {
                        ForEach(viewModel.sectionRailViewModels) { railViewModel in
                            SectionRailView(viewModel: railViewModel)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
