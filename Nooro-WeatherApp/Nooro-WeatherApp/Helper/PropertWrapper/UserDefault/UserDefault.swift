import Foundation

// MARK: - UserDefaultEncoded

/// A property wrapper for storing Codable types in `UserDefaults` by encoding them to JSON strings.
/// This allows saving and retrieving complex objects (conforming to `Codable`) in `UserDefaults`.
@propertyWrapper
struct UserDefault<T: Codable> {
    // MARK: - Properties
    
    /// The key used for storing the value in `UserDefaults`.
    let key: String
    
    /// The default value to return if no value is found in `UserDefaults`.
    let defaultValue: T

    // MARK: - Initializer
    
    /// Initializes the property wrapper with a key and default value.
    /// - Parameters:
    ///   - key: The key used for storing and retrieving the value in `UserDefaults`.
    ///   - defaultValue: The default value to return if no value exists for the specified key.
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    // MARK: - Property Wrapper
    
    /// The wrapped value that gets stored in and retrieved from `UserDefaults`.
    /// - On `get`: Tries to decode the value from `UserDefaults` using the specified key.
    ///   If decoding fails, it returns the default value.
    /// - On `set`: Encodes the new value and stores it as a JSON string in `UserDefaults`.
    var wrappedValue: T {
        get {
            // Try to retrieve the string for the given key from `UserDefaults`.
            guard let jsonString = UserDefaults.standard.string(forKey: key) else {
                return defaultValue // Return default value if no string is found.
            }
            
            // Convert the string to data using UTF-8 encoding.
            guard let jsonData = jsonString.data(using: .utf8) else {
                return defaultValue // Return default value if string to data conversion fails.
            }
            
            // Decode the JSON data into the expected value of type `T`.
            guard let value = try? JSONDecoder().decode(T.self, from: jsonData) else {
                return defaultValue // Return default value if decoding fails.
            }
            return value // Return the decoded value.
        }
        set {
            // Encode the new value using `JSONEncoder`.
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys] // Optionally format the JSON output.
            guard let jsonData = try? encoder.encode(newValue) else {
                return // Exit if encoding fails.
            }
            
            // Convert the encoded data back into a JSON string.
            let jsonString = String(bytes: jsonData, encoding: .utf8)
            
            // Store the JSON string in `UserDefaults` with the specified key.
            UserDefaults.standard.set(jsonString, forKey: key)
        }
    }

    // MARK: - Projected Value
    
    /// Provides access to the `UserDefault` wrapper itself, enabling usage like `$lastSearchedCityName`.
    var projectedValue: Self {
        self
    }

    // MARK: - Helper Functions
    
    /// Removes the value stored in `UserDefaults` for the specified key.
    func removeObject() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

// MARK: - UserDefaults Extension

/// Extension to `UserDefaults` providing a convenience for using the `UserDefault` property wrapper.
extension UserDefaults {
    /// A statically declared `UserDefault` property for accessing and modifying the `lastSearchedCityName` value.
    @UserDefault(key: "lastSearchedCityName", defaultValue: "") static var lastSearchedCityName: String
}
