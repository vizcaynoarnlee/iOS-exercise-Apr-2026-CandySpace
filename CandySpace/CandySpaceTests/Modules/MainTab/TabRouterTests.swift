import Testing
@testable import CandySpace

struct TabRouterTests {
    @Test
    func switchTab_updatesSelectedIndex() throws {
        let router: TabRouter = TabRouter()

        router.switchTab(.profile)

        #expect(router.selectedIndex == TabType.profile.id)
    }
}

