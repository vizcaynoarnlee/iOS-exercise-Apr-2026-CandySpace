//
//  ItemDetailsView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct ItemDetailsView: View {
    let viewModel: ItemDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                switch viewModel.layout {
                case .posterLeading:
                    posterLeadingHeader
                case .heroTop:
                    heroTopHeader
                }

                detailsBody
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var posterLeadingHeader: some View {
        HStack(alignment: .top, spacing: 16) {
            RemoteImageView(url: viewModel.imageURL)
                .aspectRatio(viewModel.imageAspectRatio, contentMode: .fit)
                .frame(width: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                titleBlock
                chipsBlock
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }

    private var heroTopHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            RemoteImageView(url: viewModel.imageURL)
                .aspectRatio(viewModel.imageAspectRatio, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            titleBlock
            chipsBlock
        }
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.title)
                .font(.title3.weight(.semibold))

            if let subtitle = viewModel.subtitle, subtitle.isEmpty == false {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }

            if let strapline = viewModel.strapline, strapline.isEmpty == false {
                Text(strapline)
                    .font(.subheadline)
            }
        }
    }

    private var chipsBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            if viewModel.badges.isEmpty == false {
                chipsRow(title: String(localized: "Badges"), values: viewModel.badges)
            }

            if viewModel.tiers.isEmpty == false {
                chipsRow(title: String(localized: "Tier"), values: viewModel.tiers)
            }
        }
    }

    private var detailsBody: some View {
        VStack(alignment: .leading, spacing: 12) {
            if viewModel.dates.isEmpty == false {
                detailsRow(title: String(localized: "Date"), values: viewModel.dates)
            }

            if let duration = viewModel.duration, duration.isEmpty == false {
                detailsRow(title: String(localized: "Duration"), values: [duration])
            }

            if let brand = viewModel.brandSummary {
                detailsRow(title: String(localized: "Brand"), values: [brand.title])
            }

            if let synopsis = viewModel.synopsis, synopsis.isEmpty == false {
                VStack(alignment: .leading, spacing: 6) {
                    Text(String(localized: "Synopsis"))
                        .font(.headline)
                    Text(synopsis)
                        .font(.body)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
        }
    }

    private func chipsRow(title: String, values: [String]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(values, id: \.self) { value in
                        Text(value)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color(uiColor: .label))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }

    private func detailsRow(title: String, values: [String]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            ForEach(values, id: \.self) { value in
                Text(value)
                    .font(.body)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
    }
}

