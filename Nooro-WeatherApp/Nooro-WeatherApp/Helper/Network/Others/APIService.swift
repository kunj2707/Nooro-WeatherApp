import Foundation

public enum APIService {
    
    /**
     * Request raw data from an API endpoint.
     *
     * This method sends an HTTP request to the API endpoint defined by the `rout` parameter.
     * It returns the raw data from the API response if the status code indicates success (200-299).
     * If the request fails (non-2xx status code), it throws a `APIError.badRequest` error.
     *
     * - Parameters:
     *   - `rout`: The `APIProtocol` defining the API endpoint to request.
     * - Returns: The raw data from the API endpoint.
     * - Throws: An error if the request fails (non-2xx status code).
     */
    static public func request(_ rout: APIProtocol) async throws -> Data {
        // Make an asynchronous API request using URLSession.
        let (data, res) = try await URLSession.shared.data(for: rout.asURLRequest())
        
        // Get the status code from the response, default to 400 if not available.
        let statusCode = (res as? HTTPURLResponse)?.statusCode ?? 400
        
        // Check if the status code is within the successful range (200-299).
        switch statusCode {
        case 200 ... 299:
            // If successful, return the data from the response.
            return data
        default:
            // If the status code is not in the success range, throw an error.
            throw APIError.badRequest
        }
    }
    
    /**
     * Request data from an API endpoint and decode it to a specific type.
     *
     * This method sends a request to the API endpoint defined by the `rout` parameter,
     * and returns the decoded data into the specified type `T` which conforms to `Codable`.
     * If decoding fails, it throws a decoding error.
     *
     * - Parameters:
     *   - `rout`: The `APIProtocol` defining the API endpoint to request.
     * - Returns: The decoded data of type `T` from the API endpoint.
     * - Throws: An error if the request fails or if decoding fails.
     */
    static public func request<T: Codable>(_ rout: APIProtocol) async throws -> T {
        // First, request the raw data from the API.
        let data: Data = try await request(rout)
        
        // Decode the raw data into the specified type `T` using JSONDecoder.
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /**
     * Request data from an API endpoint and decode it into a dictionary.
     *
     * This method sends a request to the API endpoint defined by the `rout` parameter,
     * and returns the decoded data as a dictionary (`[String: Any]`).
     * If the response cannot be decoded into a dictionary, it throws an `APIError.badRequest` error.
     *
     * - Parameters:
     *   - `rout`: The `APIProtocol` defining the API endpoint to request.
     * - Returns: The decoded dictionary from the API response.
     * - Throws: An error if the request fails or if the response cannot be decoded into a dictionary.
     */
    static public func request(_ rout: APIProtocol) async throws -> [String : Any] {
        // First, request the raw data from the API.
        let data: Data = try await request(rout)
        
        // Attempt to deserialize the raw data into a dictionary ([String: Any]).
        if let dict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any] {
            // If successful, return the dictionary.
            return dict
        } else {
            // If deserialization fails, throw an error.
            throw APIError.badRequest
        }
    }
}
