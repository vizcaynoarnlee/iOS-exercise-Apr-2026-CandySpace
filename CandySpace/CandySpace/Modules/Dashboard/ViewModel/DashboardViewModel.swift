//
//  DashboardViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
import CoreGraphics

protocol DashboardViewProtocol {
    var viewState: ViewState { get }
    
    func loadMedia() async
}

@Observable
final class DashboardViewModel: DashboardViewProtocol {
    private let mediaRepository: MediaRepositoryProtocol
    
    var viewState: ViewState = .initial
    
    private var media: Media?
    var sections: [Section] { media?.record.sections ?? [] }
    var sortedSections: [Section] {
        sections.sorted { left, right in
            let leftPriority: Int? = Int(left.priority ?? "")
            let rightPriority: Int? = Int(right.priority ?? "")

            switch (leftPriority, rightPriority) {
            case let (.some(lhs), .some(rhs)):
                return lhs < rhs
            case (.some, .none):
                return true
            case (.none, .some):
                return false
            case (.none, .none):
                return left.id < right.id
            }
        }
    }
    var isSectionsEmpty: Bool { sections.isEmpty }
    
    init(mediaRepository: MediaRepositoryProtocol = MediaRepository()) {
        self.mediaRepository = mediaRepository
    }

    init(mediaRepository: MediaRepositoryProtocol = MediaRepository(), initialMedia: Media) {
        self.mediaRepository = mediaRepository
        self.media = initialMedia
        self.viewState = .loaded
    }
    
    func loadMedia() async {
        guard viewState != .loading else { return }
        
        viewState = .loading
        
        do {
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            
            let media: Media = try await mediaRepository.fetchMedia()
            
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            
            self.media = media
            viewState = .loaded
        } catch {
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            viewState = .error(error)
        }
    }

    func makeSectionRailViewModels(navigate: @escaping @Sendable (DashboardRoute) -> Void) -> [SectionRailViewModel] {
        sortedSections.map { makeSectionRailViewModel(section: $0, navigate: navigate) }
    }

    func makeSectionDetailsViewModel(
        route: SectionDetailsRoute,
        navigate: @escaping @Sendable (DashboardRoute) -> Void
    ) -> SectionDetailsViewModel? {
        guard let section: Section = section(withId: route.sectionId) else { return nil }

        let layout: SectionDetailsLayout = {
            switch section.collection.imageAspectRatio {
            case .twoByThree:
                return .grid2Col
            case .sixteenByNine:
                return .fullWidthRows
            case nil:
                return .grid2Col
            }
        }()

        let aspectRatio: CGFloat = section.collection.imageAspectRatio?.cgFloatValue ?? (2.0 / 3.0)

        let items: [ItemCardViewModel] = section.items.map { item in
            let display: ContentItemDisplay = item.display
            let imageURL: URL? = display.imageURLString.flatMap(URL.init(string:))
            let itemRoute: ItemDetailsRoute = ItemDetailsRoute(sectionId: section.id, itemId: display.id)

            return ItemCardViewModel(
                id: display.id,
                imageURL: imageURL,
                badgeText: display.badgeText,
                tierText: display.tierText,
                aspectRatio: aspectRatio,
                accessibilityLabel: display.title,
                onTap: {
                    navigate(.itemDetails(itemRoute))
                }
            )
        }

        return SectionDetailsViewModel(
            sectionId: section.id,
            title: section.name,
            layout: layout,
            items: items
        )
    }

    func makeItemDetailsViewModel(route: ItemDetailsRoute) -> ItemDetailsViewModel? {
        guard let section: Section = section(withId: route.sectionId) else { return nil }
        guard let item: ContentItem = item(withId: route.itemId, in: section) else { return nil }

        let display: ContentItemDisplay = item.display
        let layout: ItemDetailsLayout = {
            switch section.collection.imageAspectRatio {
            case .sixteenByNine:
                return .heroTop
            case .twoByThree, nil:
                return .posterLeading
            }
        }()

        let imageAspectRatio: CGFloat = section.collection.imageAspectRatio?.cgFloatValue ?? (2.0 / 3.0)
        let imageURL: URL? = display.imageURLString.flatMap(URL.init(string:))

        let dates: [String] = [display.broadcastDateTime, display.latestBroadcastDateTime].compactMap { $0 }

        return ItemDetailsViewModel(
            id: display.id,
            imageURL: imageURL,
            imageAspectRatio: imageAspectRatio,
            layout: layout,
            title: display.title ?? "",
            subtitle: display.subtitle,
            strapline: display.strapline,
            synopsis: display.synopsis,
            badges: display.badges,
            tiers: display.tiers,
            dates: dates,
            duration: display.duration,
            brandSummary: display.brandSummary
        )
    }

    private func section(withId sectionId: String) -> Section? {
        sections.first { $0.id == sectionId }
    }

    private func item(withId itemId: String, in section: Section) -> ContentItem? {
        section.items.first { $0.display.id == itemId }
    }

    private func makeSectionRailViewModel(
        section: Section,
        navigate: @escaping @Sendable (DashboardRoute) -> Void
    ) -> SectionRailViewModel {
        let aspectRatio: CGFloat = section.collection.imageAspectRatio?.cgFloatValue ?? (2.0 / 3.0)
        let itemCount: Int = section.collection.itemCount
        let viewAllTitle: String = String(localized: "View All (\(itemCount))")

        let visibleItems: [ItemCardViewModel] = section.items.prefix(5).map { item in
            let display: ContentItemDisplay = item.display
            let imageURL: URL? = display.imageURLString.flatMap(URL.init(string:))
            let itemRoute: ItemDetailsRoute = ItemDetailsRoute(sectionId: section.id, itemId: display.id)

            return ItemCardViewModel(
                id: display.id,
                imageURL: imageURL,
                badgeText: display.badgeText,
                tierText: display.tierText,
                aspectRatio: aspectRatio,
                accessibilityLabel: display.title,
                onTap: {
                    navigate(.itemDetails(itemRoute))
                }
            )
        }

        return SectionRailViewModel(
            id: section.id,
            title: section.name,
            viewAllTitle: viewAllTitle,
            visibleItems: visibleItems,
            canViewAll: itemCount > 0,
            onViewAllTap: {
                navigate(.sectionDetails(SectionDetailsRoute(sectionId: section.id)))
            }
        )
    }
}
