import Foundation

/**
 Appends the given string to the end of the data.
 - Parameters:
   - string: The string to append to the data.
   - encoding: The encoding to use when converting the string to data (default is UTF-8).
 */
public extension Data {
    
    /**
     Appends the provided string to the current `Data` object.
     Converts the string to `Data` using the specified encoding and then appends it to the existing data.
     
     - Parameters:
       - string: The string to append. This string will be converted to `Data` using the provided encoding.
       - encoding: The string encoding to use when converting the string into `Data`. Defaults to `.utf8`.
     */
    mutating func append(_ string: String, encoding: String.Encoding = .utf8) {
        
        // Try to convert the string into Data using the specified encoding.
        guard let data = string.data(using: encoding) else {
            return  // If conversion fails, simply return without appending.
        }
        
        // Append the resulting Data object to the current Data object.
        append(data)
    }
}
