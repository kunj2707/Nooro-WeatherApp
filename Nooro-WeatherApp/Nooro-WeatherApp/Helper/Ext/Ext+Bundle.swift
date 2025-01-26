import Foundation

public extension Bundle {
    
    /// A computed property that returns the app's name.
    ///
    /// It first tries to get the display name (`CFBundleDisplayName`) from the app's info dictionary.
    /// If that fails, it falls back to the app's bundle name (`CFBundleName`).
    /// If both are unavailable, it defaults to "App-Name".
    var appName: String {
        // Try to retrieve the app display name from the info dictionary.
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        // Fallback to the app's bundle name if display name is unavailable.
        ?? object(forInfoDictionaryKey: "CFBundleName") as? String
        // Default value if both are unavailable.
        ?? "App-Name"
    }
}
