import SwiftUI

@main
struct PointrApp: App {

    // MARK: - ViewModel
    @StateObject var viewModel = LogModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
