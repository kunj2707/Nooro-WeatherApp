import UIKit

// Extension to add a convenience property for accessing the key window of the application.
public extension UIApplication {
    
    // A computed property to get the current key window of the app.
    static var keyWindow: UIWindow? {
        // Accesses the shared instance of UIApplication and iterates through all connected scenes.
        shared.connectedScenes
            // Filters the scenes to find UIWindowScene instances and accesses their key window.
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            // Returns the last key window found in the sequence.
            .last
    }
}
