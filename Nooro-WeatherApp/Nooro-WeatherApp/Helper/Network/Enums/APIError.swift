import Foundation

// MARK: - APIError
/**
 *  An enumeration representing possible errors that can occur when making an API request.
 *  This enum conforms to the `Error` protocol and allows handling specific API-related errors.
 */
enum APIError: Error {
    
    /**
     *  Indicates that the API request was invalid (e.g., bad parameters, wrong HTTP method).
     */
    case badRequest
    
    /**
     *  Indicates that the provided URL is not valid.
     *  - Parameter urlStr: The URL string that was determined to be invalid.
     */
    case invalidURL(urlStr: String)
}

// MARK: - LocalizedError
/**
 *  Conforming to the `LocalizedError` protocol allows `APIError` to provide a custom description
 *  for each error case when converted to a string, which can be useful for displaying user-friendly messages.
 */
extension APIError: LocalizedError {
    
    /**
     *  Provides a custom error description for each case of `APIError`.
     *  This description is returned as a localized string that can be shown to users.
     */
    private var errorDescription: String {
        switch self {
        case .badRequest:
            // Localized description for a bad request error
            return NSLocalizedString("Api request is bad.", comment: "Api request is bad.")
            
        case let .invalidURL(urlStr):
            // Localized description for an invalid URL error, includes the URL that caused the error
            return NSLocalizedString("\(urlStr) is invalid url.", comment: "\(urlStr) is invalid url.")
        }
    }
}
