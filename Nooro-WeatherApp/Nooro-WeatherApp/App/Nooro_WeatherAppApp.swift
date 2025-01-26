import SwiftUI

@main
struct Nooro_WeatherAppApp: App {
    
    // MARK: - Properties
    /// The `AppDelegate` instance to handle application lifecycle events.
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

