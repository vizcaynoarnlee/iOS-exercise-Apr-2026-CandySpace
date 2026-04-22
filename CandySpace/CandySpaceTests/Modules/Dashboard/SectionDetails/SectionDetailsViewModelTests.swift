import Testing
@testable import CandySpace

struct SectionDetailsViewModelTests {
    @Test
    func makeSectionDetails_twoByThree_usesGrid2Col_andAllItems() throws {
        let section: Section = Section(
            id: "sec2x3",
            name: "TwoByThree",
            type: .rail,
            priority: "1",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: TestFixtures.collectionInfo(aspectRatio: .twoByThree, itemCount: 2),
            items: [
                .brand(
                    BrandItem(
                        id: "brd1",
                        type: "brand",
                        title: "Brand",
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

        let media: Media = TestFixtures.media(sections: [section])
        let viewModel: DashboardViewModel = DashboardViewModel(initialMedia: media)
        let route: SectionDetailsRoute = SectionDetailsRoute(sectionId: "sec2x3")

        let details: SectionDetailsViewModel? = viewModel.makeSectionDetailsViewModel(route: route, navigate: { _ in })

        #expect(details?.layout == .grid2Col)
        #expect(details?.items.count == 2)
    }
}

