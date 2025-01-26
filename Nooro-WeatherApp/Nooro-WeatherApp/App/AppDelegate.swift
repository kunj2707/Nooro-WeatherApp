import UIKit

// AppDelegate class to handle app-level lifecycle events and dependencies
final class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Properties
    // Add properties here if needed for global app-level configurations
    
    // MARK: - Life Cycles
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        registerDepenency()
        return true
    }
    
    // MARK: - Functions
    /// Registers dependencies to be used across the app.
    /// This setup is done through a dependency injection framework, Resolver in this case.
    private func registerDepenency() {
        Resolver.default.register(type: NetworkService.self, factory: NetworkManager())
    }
}
