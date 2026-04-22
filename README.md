# CandySpace (iOS Technical Test)

SwiftUI iOS app that loads a media payload from a remote API and presents it as a **dashboard of horizontal rails**. Tapping an item navigates to **item details**, and tapping **View All** navigates to **section details**.

## Demo

The repository includes a short demo recording:

- `Apr-22-2026 22-00-50.gif`

If your Markdown renderer supports images, you should see it below.

![CandySpace demo](./Apr-22-2026%2022-00-50.gif)

## Features

- **Dashboard rails**: vertically stacked rails, each with horizontally scrolling cards and a **View All** action.
- **Shimmering skeleton loading**: shimmer-based placeholders while content is loading.
- **Section details**: layout adapts based on each section’s **image aspect ratio**.
- **Item details**: layout adapts based on **image aspect ratio** and content type (via display mapping).
- **Dark & light mode**: UI supports system appearance.
- **Loading / error / empty states**: retry on error and empty-state messaging.
- **Unit tests**: repository/view-model behavior is covered with spies/stubs/fixtures.

## Project structure

High-level layout is **feature-first**:

- **`CandySpace/CandySpace/App/`**: app entry point (`CandySpaceApp`)
- **`CandySpace/CandySpace/Modules/`**: feature modules
  - **`MainTab/`**: tab shell + routing state
  - **`Dashboard/`**: dashboard, navigation routes, details screens, and components
  - **`Profile/`**: profile tab
- **`CandySpace/CandySpace/Common/`**: shared UI components + shared enums/state
- **`CandySpace/CandySpace/Network/`**: API client, endpoints, repository, and Codable models
- **`CandySpace/CandySpaceTests/`**: unit tests (spies/stubs/fixtures)

## Architecture & design patterns

- **MVVM (SwiftUI)**:
  - Views remain declarative and state-driven (e.g. `DashboardView` renders based on `ViewState`).
  - View models own orchestration and derive UI-ready state (e.g. `DashboardViewModel` builds rail/card view models).
- **Dependency Inversion**:
  - Features depend on abstractions like `MediaRepositoryProtocol` and `APIClientProtocol`.
  - Tests inject stubs/spies for deterministic unit tests.
- **Repository pattern**:
  - `MediaRepository` is the boundary between features and networking.
- **Typed navigation**:
  - `DashboardRoute`, `SectionDetailsRoute`, and `ItemDetailsRoute` provide type-safe destinations.
- **Tab routing & navigation setup**:
  - `MainTabView` hosts a `TabView` driven by `TabRouter` (`selectedIndex` + `switchTab`).
  - `DashboardView` uses `NavigationStack` with a typed `[DashboardRoute]` path and `navigationDestination` to present details screens.
- **Display mapping (adapter)**:
  - `ContentItem+Display` maps heterogeneous API items into a consistent `ContentItemDisplay` used by UI composition.
- **Aspect-ratio-driven layout**:
  - `ImageAspectRatio` from the API influences card sizing and details layouts for consistent presentation.

## How to run

### Requirements

- **macOS** with **Xcode** installed
- **iOS Simulator** (or a physical device)

### Steps

1. Open `CandySpace/CandySpace.xcodeproj` in Xcode.
2. Select a simulator (e.g. iPhone 15) or a connected device.
3. Build and run using **Product → Run** (or `Cmd + R`).

### Tests

Run unit tests via **Product → Test** (or `Cmd + U`).

## Next improvements

If extending this codebase further, these are high-impact improvements to keep it scalable and maintainable:

- **Centralized dependency injection**: move construction of `APIClient` / `MediaRepository` / feature view models into a composition root (better previews, mocks, and environment configs).
- **Separate navigation factories from feature state**: extract “build destination view models” out of `DashboardViewModel` into a coordinator/factory.
- **APIClient cleanup**: unify request building + decoding (remove `get`/`getArray` duplication) and improve error mapping.
- **Configuration**: pull `baseURLString` and endpoint IDs into environment-based config (Debug/Release) rather than literals.
- **Main-actor safety**: ensure view-model state mutations are `@MainActor` and cancellation can’t leave the UI stuck in `.loading`.
- **`ViewState` error identity**: make `.error` equatable in a meaningful way (e.g. store an equatable error descriptor) to avoid false positives.
- **Centralize theme/design system**: define consistent colors/typography/spacing in one place (and optionally support dynamic type) to keep UI consistent across modules.
- **Snapshot tests**: add snapshot coverage for key screens/components (dashboard rails, section details layouts, item details layouts) across light/dark mode and key aspect ratios.
