//
//  Shimmer.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import SwiftUI

/// A subtle shimmering effect that can be applied to any view.
///
/// This is intended for skeleton/loading placeholders and respects Reduce Motion.
struct ShimmerModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion: Bool
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    let isActive: Bool
    let speed: Double
    let angle: Angle
    let highlightOpacity: Double

    @State private var phase: CGFloat = -1.0

    func body(content: Content) -> some View {
        content
            .overlay(overlay)
            .onAppear {
                guard isShimmering else { return }
                phase = -1.0
                animate()
            }
            .onChange(of: isShimmering) { _, newValue in
                if newValue {
                    phase = -1.0
                    animate()
                }
            }
    }

    @ViewBuilder
    private var overlay: some View {
        if isShimmering {
            GeometryReader { proxy in
                let size: CGSize = proxy.size
                shimmerGradient
                    .frame(width: size.width * 1.5, height: size.height * 1.5)
                    .rotationEffect(angle)
                    .offset(x: size.width * phase, y: 0)
                    .blendMode(blendMode)
            }
            .mask(contentMask)
            .allowsHitTesting(false)
            .accessibilityHidden(true)
        }
    }

    private var contentMask: some View {
        Rectangle().fill(Color.white)
    }

    private var shimmerGradient: LinearGradient {
        let base: Color = Color.white.opacity(0.0)
        let highlight: Color = Color.white.opacity(highlightOpacity)
        return LinearGradient(
            stops: [
                .init(color: base, location: 0.0),
                .init(color: highlight, location: 0.5),
                .init(color: base, location: 1.0),
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private var isShimmering: Bool {
        isActive && reduceMotion == false
    }

    private var blendMode: BlendMode {
        switch colorScheme {
        case .light:
            return .screen
        case .dark:
            return .plusLighter
        @unknown default:
            return .plusLighter
        }
    }

    private func animate() {
        withAnimation(.linear(duration: speed).repeatForever(autoreverses: false)) {
            phase = 1.0
        }
    }
}

extension View {
    /// Applies a subtle shimmering effect to the view.
    ///
    /// - Parameters:
    ///   - isActive: Whether the shimmer animation should run.
    ///   - speed: Duration (seconds) for a full shimmer sweep.
    ///   - angle: The angle of the shimmer band.
    ///   - highlightOpacity: Opacity of the shimmer highlight band.
    func shimmer(
        isActive: Bool = true,
        speed: Double = 1.25,
        angle: Angle = .degrees(12),
        highlightOpacity: Double = 0.18
    ) -> some View {
        modifier(
            ShimmerModifier(
                isActive: isActive,
                speed: speed,
                angle: angle,
                highlightOpacity: highlightOpacity
            )
        )
    }
}

