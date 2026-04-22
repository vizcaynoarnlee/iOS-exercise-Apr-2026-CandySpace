//
//  RemoteImageView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

struct RemoteImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder

            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                placeholder

            @unknown default:
                placeholder
            }
        }
        .background(Color.white.opacity(0.08))
    }

    private var placeholder: some View {
        ZStack {
            Color.white.opacity(0.08)
            Image(systemName: "photo")
                .foregroundStyle(.white.opacity(0.35))
        }
    }
}
