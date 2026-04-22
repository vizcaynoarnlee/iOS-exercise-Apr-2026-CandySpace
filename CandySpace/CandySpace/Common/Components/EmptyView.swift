//
//  EmptyView.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//


import SwiftUI

struct EmptyView: View {
    var message: String?
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "xmark.bin.circle")
                .foregroundColor(.gray)
                .font(.largeTitle)
            Text(message ?? "Empty list.")
                .font(.caption)
        }
    }
}

#Preview {
    EmptyView()
}