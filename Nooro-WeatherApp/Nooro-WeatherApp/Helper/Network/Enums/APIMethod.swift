import Foundation

// MARK: - APIMethod
/**
 *  An enumeration that represents the supported HTTP methods for making an API request.
 *  Each case corresponds to a different type of HTTP request method.
 */
public enum APIMethod: String {
    
    /**
     *  Indicates a GET request, typically used for retrieving data from the server.
     */
    case get
    
    /**
     *  Indicates a POST request, typically used for creating new resources on the server.
     */
    case post
    
    /**
     *  Indicates a PUT request, typically used for updating existing resources on the server.
     */
    case put
    
    /**
     *  Indicates a PATCH request, typically used for making partial updates to resources.
     */
    case patch
    
    /**
     *  Indicates a DELETE request, typically used for deleting resources from the server.
     */
    case delete
}

// MARK: - ABRequest
/**
 *  An enumeration that represents different types of request bodies and parameters for making an API request.
 *  It includes several cases to support different encoding types for the request body.
 */
public enum ABRequest {
    
    /**
     *  Indicates that the request body is JSON-encoded.
     *  - Parameter model: The data model to be encoded as JSON.
     */
    case jsonEncoding(_ model: [String: Any]?)
    
    /**
     *  Indicates that the request body is URL-encoded.
     *  - Parameter model: The data model to be encoded as URL parameters.
     */
    case urlEncoding(_ model: [String: Any]?)
    
    /**
     *  Indicates that the request query parameters are provided as a dictionary.
     *  - Parameter dict: A dictionary of query parameters to be included in the URL.
     */
    case queryString(_ dict: [String: Any]?)
    
    /**
     *  Indicates that the request body is multipart/form-data, often used for file uploads.
     *  - Parameter multiPart: The multipart data to be sent in the request body.
     */
    case multiPart(_ multiPart: MultipartRequest)
    
    /**
     *  Indicates that the request body is plain and not encoded.
     */
    case requestPlain

    // MARK: - Internal

    /**
     *  Returns the JSON-encoded body of the request if applicable.
     *  This property is used when the request body is JSON-encoded.
     */
    internal var jsonBody: [String: Any]? {
        switch self {
        case let .jsonEncoding(model):
            return model // Return the JSON model if it's a JSONEncoding request
        case .urlEncoding, .queryString, .multiPart, .requestPlain:
            return nil // No JSON body for other request types
        }
    }
    
    /**
     *  Returns the URL-encoded body of the request if applicable.
     *  This property is used when the request body is URL-encoded.
     */
    internal var urlParams: [String: Any]? {
        switch self {
        case let .urlEncoding(model):
            return model // Return the URL parameters if it's a URLEncoding request
        case .jsonEncoding, .queryString, .multiPart, .requestPlain:
            return nil // No URL parameters for other request types
        }
    }

    /**
     *  Returns the query parameters of the request.
     *  This property is used when the request has query parameters, such as in GET requests.
     */
    internal var queryItem: [URLQueryItem] {
        switch self {
        case .jsonEncoding, .urlEncoding, .multiPart, .requestPlain:
            return [] // No query items for these request types
        case let .queryString(dict):
            return dict?.asQueryParam ?? [] // Convert dictionary to query parameters if it's a queryString request
        }
    }

    /**
     *  Returns the multipart/form-data of the request if applicable.
     *  This property is used when the request body is multipart/form-data (e.g., for file uploads).
     */
    internal var formData: MultipartRequest? {
        switch self {
        case .jsonEncoding, .urlEncoding, .queryString, .requestPlain:
            return nil // No form data for these request types
        case let .multiPart(multiPart):
            return multiPart // Return multipart data if it's a multiPart request
        }
    }
}
