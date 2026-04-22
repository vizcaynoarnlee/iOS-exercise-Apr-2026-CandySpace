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
            strapline: nil,
            imageUrl: "https://example.com/image.jpg",
            categories: nil,
            genres: nil,
            subgenres: nil,
            badges: ["NEW SERIES"],
            accessibility: AccessibilityInfo(subtitled: true, audioDescribed: false, signed: false),
            tier: ["FREE"],
            contentOwner: nil,
            synopsis: nil,
            latestBroadcastDateTime: nil
        )

        let display: ContentItemDisplay = ContentItem.brand(brand).display

        #expect(display.id == "brd1")
        #expect(display.imageURLString == "https://example.com/image.jpg")
        #expect(display.badgeText == "NEW SERIES")
        #expect(display.tierText == "FREE")
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
