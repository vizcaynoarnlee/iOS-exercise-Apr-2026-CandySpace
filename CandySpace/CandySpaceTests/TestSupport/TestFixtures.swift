import Foundation
@testable import CandySpace

enum TestFixtures {
    static let pageInfo: PageInfo = PageInfo(
        id: "page1",
        name: nil,
        imageUrl: nil,
        adServed: false
    )

    static let metadata: Metadata = Metadata(
        id: "meta1",
        private: false,
        createdAt: "2026-04-22T00:00:00Z",
        name: "fixture"
    )

    static func collectionInfo(aspectRatio: ImageAspectRatio?, itemCount: Int) -> CollectionInfo {
        CollectionInfo(
            id: "col1",
            title: "Collection",
            itemCount: itemCount,
            imageTreatment: nil,
            imageAspectRatio: aspectRatio,
            imageClass: nil,
            excludeTimeDependentTags: false,
            adServed: false,
            subsequentJourney: nil
        )
    }

    static func media(sections: [Section]) -> Media {
        Media(
            record: Record(page: pageInfo, sections: sections),
            metadata: metadata
        )
    }
}

