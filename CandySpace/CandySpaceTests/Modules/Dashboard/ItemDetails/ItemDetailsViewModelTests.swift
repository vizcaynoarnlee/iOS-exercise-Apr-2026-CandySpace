import Testing
@testable import CandySpace

struct ItemDetailsViewModelTests {
    @Test
    func makeItemDetails_sixteenByNine_usesHeroTop_andMapsFields() throws {
        let film: FilmItem = FilmItem(
            id: "flm1",
            type: "film",
            title: "Film",
            strapline: "Strap",
            imageUrl: "https://example.com/film.jpg",
            badges: ["RECENTLY ADDED"],
            broadcastDateTime: "2026-04-22T10:00:00Z",
            episodeNumber: nil,
            duration: "PT45M",
            brand: BrandSummary(
                id: "brd1",
                title: "Brand",
                imageUrl: "https://example.com/brand.jpg",
                categories: nil,
                genres: nil,
                subgenres: nil,
                synopsis: nil
            ),
            tier: ["FREE"],
            synopsis: "Synopsis",
            accessibility: AccessibilityInfo(subtitled: false, audioDescribed: false, signed: false)
        )

        let section: Section = Section(
            id: "sec16x9",
            name: "SixteenByNine",
            type: .rail,
            priority: "1",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: TestFixtures.collectionInfo(aspectRatio: .sixteenByNine, itemCount: 1),
            items: [.film(film)]
        )

        let media: Media = TestFixtures.media(sections: [section])
        let viewModel: DashboardViewModel = DashboardViewModel(initialMedia: media)
        let route: ItemDetailsRoute = ItemDetailsRoute(sectionId: "sec16x9", itemId: "flm1")

        let details: ItemDetailsViewModel? = viewModel.makeItemDetailsViewModel(route: route)

        #expect(details?.layout == .heroTop)
        #expect(details?.title == "Film")
        #expect(details?.strapline == "Strap")
        #expect(details?.synopsis == "Synopsis")
        #expect(details?.badges == ["RECENTLY ADDED"])
        #expect(details?.tiers == ["FREE"])
        #expect(details?.dates == ["2026-04-22T10:00:00Z"])
        #expect(details?.duration == "PT45M")
        #expect(details?.brandSummary?.title == "Brand")
    }
}

