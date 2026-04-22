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
    var sectionRailViewModels: [SectionRailViewModel] {
        sortedSections.map(makeSectionRailViewModel(section:))
    }
    
    init(mediaRepository: MediaRepositoryProtocol = MediaRepository()) {
        self.mediaRepository = mediaRepository
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

    private func makeSectionRailViewModel(section: Section) -> SectionRailViewModel {
        let aspectRatio: CGFloat = section.collection.imageAspectRatio?.cgFloatValue ?? (2.0 / 3.0)
        let itemCount: Int = section.collection.itemCount
        let viewAllTitle: String = String(localized: "View All (\(itemCount))")

        let visibleItems: [ItemCardViewModel] = section.items.prefix(5).map { item in
            let display: ContentItemDisplay = item.display
            let imageURL: URL? = display.imageURLString.flatMap(URL.init(string:))

            return ItemCardViewModel(
                id: display.id,
                imageURL: imageURL,
                badgeText: display.badgeText,
                tierText: display.tierText,
                aspectRatio: aspectRatio,
                accessibilityLabel: nil,
                onTap: {
                    debugPrint("ItemTap: \(display.id)")
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
                debugPrint("ViewAll: \(section.name)")
            }
        )
    }
}
