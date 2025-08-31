import SwiftUI

@main
struct MacroFitApp: App {
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(viewModel)
            .preferredColorScheme(.light)
        }
    }
}
