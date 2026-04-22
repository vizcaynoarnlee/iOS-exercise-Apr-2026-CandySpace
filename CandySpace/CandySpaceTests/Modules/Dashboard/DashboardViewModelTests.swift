import Foundation
import Testing
@testable import CandySpace

struct DashboardViewModelTests {
    @Test
    func loadMedia_setsLoaded_andBuildsRails() async throws {
        let section: Section = Section(
            id: "sec1",
            name: "Section",
            type: .rail,
            priority: "1",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: TestFixtures.collectionInfo(aspectRatio: .twoByThree, itemCount: 10),
            items: (0 ..< 8).map { index in
                let item: BrandItem = BrandItem(
                    id: "brd\(index)",
                    type: "brand",
                    title: "Title\(index)",
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
                return .brand(item)
            }
        )

        let media: Media = TestFixtures.media(sections: [section])
        let repository: MediaRepositoryStub = MediaRepositoryStub(media: media)
        let viewModel: DashboardViewModel = DashboardViewModel(mediaRepository: repository)

        await viewModel.loadMedia()

        #expect(viewModel.viewState == .loaded)

        let rails: [SectionRailViewModel] = viewModel.makeSectionRailViewModels(navigate: { _ in })
        #expect(rails.count == 1)
        #expect(rails.first?.title == "Section")
        #expect(rails.first?.viewAllTitle.contains("10") == true)
        #expect(rails.first?.visibleItems.count == 5)
    }
}

