import Foundation

/**
 Creates a URLQueryItem array from the dictionary.
 This extension allows you to easily convert a dictionary with `String` keys
 and any value that can be converted to a `String` into an array of `URLQueryItem` objects.
 `URLQueryItem` is used to represent query parameters in URLs.

 - Returns: An array of `URLQueryItem` objects created from the dictionary.
 */
public extension Dictionary where Key == String {
    
    /**
     Converts the dictionary into an array of `URLQueryItem` objects.
     
     This method iterates over the dictionary and creates `URLQueryItem` for each key-value pair,
     where the value is expected to be something that can be represented as a `String`.
     It uses `CustomStringConvertible` to extract a `String` representation of the value.
     
     - Returns: An array of `URLQueryItem` objects created from the dictionary.
     */
    var asQueryParam: [URLQueryItem] {
        
        // Iterate over the dictionary, creating a URLQueryItem for each key-value pair.
        compactMap { key, value in
            // Attempt to convert the value into a string using the CustomStringConvertible protocol.
            let stringValue: String
            if let stringConvertible = value as? CustomStringConvertible {
                stringValue = stringConvertible.description // Use description property for value conversion.
            } else {
                return nil // If value cannot be converted to string, skip this item.
            }
            
            // Return the URLQueryItem for the given key and string value.
            return URLQueryItem(name: key, value: stringValue)
        }
    }
}
