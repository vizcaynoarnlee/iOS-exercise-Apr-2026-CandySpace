//
//  DashboardView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct DashboardView: View {
    @State var viewModel: DashboardViewModel = .init()
    @State private var path: [DashboardRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.viewState {
                case .initial, .loading:
                    DashboardSkeletonView()

                case .loaded:
                    contentView

                case let .error(error):
                    ErrorView(
                        errorMessage: error.localizedDescription,
                        onRefresh: {
                            Task { await refresh() }
                        }
                    )
                }
            }
            .task {
                if viewModel.viewState == .initial {
                    await viewModel.loadMedia()
                }
            }
            .navigationDestination(for: DashboardRoute.self) { route in
                switch route {
                case let .sectionDetails(sectionRoute):
                    if let detailsViewModel = viewModel.makeSectionDetailsViewModel(
                        route: sectionRoute,
                        navigate: { path.append($0) }
                    ) {
                        SectionDetailsView(viewModel: detailsViewModel)
                    } else {
                        ErrorView(errorMessage: String(localized: "Section not found."))
                    }
                case let .itemDetails(itemRoute):
                    if let itemViewModel = viewModel.makeItemDetailsViewModel(route: itemRoute) {
                        ItemDetailsView(viewModel: itemViewModel)
                    } else {
                        ErrorView(errorMessage: String(localized: "Item not found."))
                    }
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
                        ForEach(viewModel.makeSectionRailViewModels(navigate: { path.append($0) })) { railViewModel in
                            SectionRailView(viewModel: railViewModel)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .refreshable {
                    await refresh()
                }
            }
        }
    }

    private func refresh() async {
        await viewModel.loadMedia()
    }
}

#Preview {
    DashboardView()
}
