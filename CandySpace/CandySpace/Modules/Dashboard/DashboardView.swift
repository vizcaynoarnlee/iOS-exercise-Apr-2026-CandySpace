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
                    ProgressView("loading...")

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
            if viewModel.isMediaEmpty {
                EmptyView(message: "No media found.")
            } else {
                Text("Media \(viewModel.media?.record.sections.count ?? 0)")
            }
        }
    }
}

#Preview {
    DashboardView()
}
