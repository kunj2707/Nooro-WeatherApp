import Foundation

/**
 Encodes the receiver (any `Encodable` object) as JSON data using the `JSONEncoder`.
 The computed property `asDictionary` converts an object that conforms to the `Encodable` protocol
 into a dictionary (`[String: Any]?`) by first encoding the object into JSON data
 and then deserializing it into a dictionary.

 - Returns: The dictionary representation of the object, or `nil` if encoding or deserialization fails.
 */
public extension Encodable {
    
    /**
     Converts the current `Encodable` object into a dictionary.
     
     - The object is first encoded into JSON data using `JSONEncoder`.
     - The JSON data is then deserialized into a dictionary of type `[String: Any]` using `JSONSerialization`.
     - The result will be a dictionary representation of the object if successful, or `nil` if any step fails (encoding or deserialization).

     - Returns: A dictionary (`[String: Any]`) representation of the object, or `nil` if encoding or deserialization fails.
     */
    var asDictionary: [String: Any]? {
        
        // Attempt to encode the object into JSON data using JSONEncoder.
        guard let data = try? JSONEncoder().encode(self) else {
            return nil // If encoding fails, return nil.
        }
        
        // Attempt to deserialize the JSON data into a dictionary using JSONSerialization.
        return (try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments)) // Deserialize into a generic object.
            .flatMap { $0 as? [String: Any] } // Attempt to cast the result to a dictionary.
    }
}
