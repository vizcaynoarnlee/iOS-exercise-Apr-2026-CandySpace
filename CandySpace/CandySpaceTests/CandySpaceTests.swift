//
//  CandySpaceTests.swift
//  CandySpaceTests
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Testing

struct CandySpaceTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}

extension CandySpaceTests {
    @Test
    func contentItemDisplay_mapsCommonFields() throws {
        let brand: BrandItem = BrandItem(
            id: "brd1",
            type: "brand",
            title: "Brand",
            strapline: "Strap",
            imageUrl: "https://example.com/image.jpg",
            categories: nil,
            genres: nil,
            subgenres: nil,
            badges: ["NEW SERIES", "RECENTLY ADDED"],
            accessibility: AccessibilityInfo(subtitled: true, audioDescribed: false, signed: false),
            tier: ["FREE", "PREMIUM"],
            contentOwner: nil,
            synopsis: "Synopsis",
            latestBroadcastDateTime: "2026-04-22T10:00:00Z"
        )

        let display: ContentItemDisplay = ContentItem.brand(brand).display

        #expect(display.id == "brd1")
        #expect(display.imageURLString == "https://example.com/image.jpg")
        #expect(display.badgeText == "NEW SERIES")
        #expect(display.tierText == "FREE")
        #expect(display.title == "Brand")
        #expect(display.subtitle == nil)
        #expect(display.strapline == "Strap")
        #expect(display.synopsis == "Synopsis")
        #expect(display.badges == ["NEW SERIES", "RECENTLY ADDED"])
        #expect(display.tiers == ["FREE", "PREMIUM"])
        #expect(display.latestBroadcastDateTime == "2026-04-22T10:00:00Z")
    }

    @Test
    func sectionPrioritySort_numericAscending_invalidLast() throws {
        let section1: Section = Section(
            id: "sec1",
            name: "High",
            type: .rail,
            priority: "10",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: SectionSortingFixtures.collectionInfo,
            items: []
        )

        let section2: Section = Section(
            id: "sec2",
            name: "Low",
            type: .rail,
            priority: "2",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: SectionSortingFixtures.collectionInfo,
            items: []
        )

        let section3: Section = Section(
            id: "sec3",
            name: "Invalid",
            type: .rail,
            priority: "not-a-number",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: SectionSortingFixtures.collectionInfo,
            items: []
        )

        let sorted: [Section] = [section1, section2, section3].sorted { left, right in
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

        #expect(sorted.map(\.id) == ["sec2", "sec1", "sec3"])
    }

    @Test
    func sectionDetails_layoutSelection_twoByThree_isGrid() throws {
        let media: Media = Media(
            record: Record(
                page: SectionDetailsFixtures.pageInfo,
                sections: [SectionDetailsFixtures.sectionTwoByThree]
            ),
            metadata: SectionDetailsFixtures.metadata
        )

        let viewModel: DashboardViewModel = DashboardViewModel(initialMedia: media)
        let route: SectionDetailsRoute = SectionDetailsRoute(sectionId: SectionDetailsFixtures.sectionTwoByThree.id)
        let details: SectionDetailsViewModel? = viewModel.makeSectionDetailsViewModel(route: route, navigate: { _ in })

        #expect(details?.layout == .grid2Col)
    }

    @Test
    func itemDetails_layoutSelection_sixteenByNine_isHeroTop() throws {
        let media: Media = Media(
            record: Record(
                page: SectionDetailsFixtures.pageInfo,
                sections: [SectionDetailsFixtures.sectionSixteenByNine]
            ),
            metadata: SectionDetailsFixtures.metadata
        )

        let viewModel: DashboardViewModel = DashboardViewModel(initialMedia: media)
        let itemId: String = SectionDetailsFixtures.sectionSixteenByNine.items.first?.display.id ?? "unknown"
        let route: ItemDetailsRoute = ItemDetailsRoute(sectionId: SectionDetailsFixtures.sectionSixteenByNine.id, itemId: itemId)
        let details: ItemDetailsViewModel? = viewModel.makeItemDetailsViewModel(route: route)

        #expect(details?.layout == .heroTop)
    }
}

private enum SectionSortingFixtures {
    static let collectionInfo: CollectionInfo = CollectionInfo(
        id: "c1",
        title: nil,
        itemCount: 0,
        imageTreatment: nil,
        imageAspectRatio: .twoByThree,
        imageClass: nil,
        excludeTimeDependentTags: false,
        adServed: false,
        subsequentJourney: nil
    )
}

private enum SectionDetailsFixtures {
    static let pageInfo: PageInfo = PageInfo(
        id: "p1",
        name: nil,
        imageUrl: nil,
        adServed: false
    )

    static let metadata: Metadata = Metadata(
        id: "m1",
        private: false,
        createdAt: "2026-04-22T00:00:00Z",
        name: "test"
    )

    static let collectionTwoByThree: CollectionInfo = CollectionInfo(
        id: "c2x3",
        title: nil,
        itemCount: 2,
        imageTreatment: nil,
        imageAspectRatio: .twoByThree,
        imageClass: nil,
        excludeTimeDependentTags: false,
        adServed: false,
        subsequentJourney: nil
    )

    static let collectionSixteenByNine: CollectionInfo = CollectionInfo(
        id: "c16x9",
        title: nil,
        itemCount: 1,
        imageTreatment: nil,
        imageAspectRatio: .sixteenByNine,
        imageClass: nil,
        excludeTimeDependentTags: false,
        adServed: false,
        subsequentJourney: nil
    )

    static let sectionTwoByThree: Section = Section(
        id: "sec2x3",
        name: "TwoByThree",
        type: .rail,
        priority: "1",
        displayType: nil,
        platformDisplayType: nil,
        destination: nil,
        collection: collectionTwoByThree,
        items: [
            .brand(
                BrandItem(
                    id: "brd2",
                    type: "brand",
                    title: "Brand2",
                    strapline: nil,
                    imageUrl: nil,
                    categories: nil,
                    genres: nil,
                    subgenres: nil,
                    badges: [],
                    accessibility: AccessibilityInfo(subtitled: false, audioDescribed: false, signed: false),
                    tier: [],
                    contentOwner: nil,
                    synopsis: nil,
                    latestBroadcastDateTime: nil
                )
            ),
        ]
    )

    static let sectionSixteenByNine: Section = Section(
        id: "sec16x9",
        name: "SixteenByNine",
        type: .rail,
        priority: "1",
        displayType: nil,
        platformDisplayType: nil,
        destination: nil,
        collection: collectionSixteenByNine,
        items: [
            .film(
                FilmItem(
                    id: "flm1",
                    type: "film",
                    title: "Film",
                    strapline: nil,
                    imageUrl: nil,
                    badges: [],
                    broadcastDateTime: nil,
                    episodeNumber: nil,
                    duration: nil,
                    brand: nil,
                    tier: [],
                    synopsis: nil,
                    accessibility: AccessibilityInfo(subtitled: false, audioDescribed: false, signed: false)
                )
            ),
        ]
    )
}
