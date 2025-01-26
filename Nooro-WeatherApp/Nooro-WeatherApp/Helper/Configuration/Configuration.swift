import Foundation

/// A utility to fetch and decode configuration values from the app's Info.plist file.
enum Configuration {
    
    // MARK: - Error Types
    
    /// Errors that can occur while fetching configuration values.
    enum Error: Swift.Error {
        /// Thrown when the specified key is missing in the Info.plist file.
        case missingKey
        
        /// Thrown when the value for the key is invalid or cannot be converted to the desired type.
        case invalidValue
    }
    
    // MARK: - Public Methods
    
    /// Retrieves and decodes a value from the Info.plist file.
    /// - Parameters:
    ///   - key: The key to look for in the Info.plist file.
    /// - Throws:
    ///   - `Configuration.Error.missingKey` if the key does not exist in the Info.plist file.
    ///   - `Configuration.Error.invalidValue` if the value cannot be converted to the specified type.
    /// - Returns: The value associated with the key, cast to the specified type.
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        // Retrieve the object associated with the key from the Info.plist file.
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            // Throw an error if the key is not found.
            throw Error.missingKey
        }
        
        // Try to cast the object to the expected type or convert it if it's a string.
        switch object {
        case let value as T:
            // If the object is already of the expected type, return it.
            return value
        case let string as String:
            // If the object is a string, attempt to initialize the expected type from it.
            guard let value = T(string) else { fallthrough }
            return value
        default:
            // Throw an error if the value cannot be converted to the expected type.
            throw Error.invalidValue
        }
    }
}

