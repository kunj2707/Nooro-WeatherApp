import Foundation

// MARK: - APIProtocol
/**
 The `APIProtocol` protocol defines the basic properties of an API request.
 It outlines the necessary information to configure and make an API request.

 - `method`: The HTTP method used for the request (GET, POST, etc.).
 - `baseURL`: The base URL of the API endpoint.
 - `path`: The relative path of the API endpoint (to be appended to the baseURL).
 - `task`: The request task that contains additional details like query parameters, request body, etc.
 - `header`: A dictionary containing the request headers.

 The `asURLRequest()` method converts the `APIProtocol` instance to a `URLRequest` instance. This method:
 - Adds any query parameters from the `task` to the URL.
 - Creates a valid `URL` from the combined base URL and path.
 - Adds headers from the `header` property to the request.
 - Sets the HTTP method based on the `method` property.
 - Sets the request body based on the `task` (either JSON body, form data, or URL-encoded parameters).

 Additionally, the `asURLRequest()` method prints the generated `curl` command to the debug console for easy testing.

 */
public protocol APIProtocol {
    var method: APIMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var task: ABRequest { get }
    var header: [String: String] { get }
}

// MARK: - Extension
extension APIProtocol {
    /**
     Converts the `APIProtocol` instance to a `URLRequest` instance.

     This method constructs a valid `URLRequest` from the properties of the `APIProtocol`:
     - The `baseURL` and `path` are combined to form the complete URL.
     - Any query parameters (from `task.queryItem`) are added to the URL.
     - The request headers (from `header`) are applied to the request.
     - The HTTP method is set based on the `method` property.
     - The body of the request is determined based on the `task` (could be JSON, form data, or URL-encoded parameters).

     - Returns: The `URLRequest` instance.
     - Throws: An `APIError` if the URL is invalid or cannot be constructed.
     */
    func asURLRequest() throws -> URLRequest {
        // Attempt to create a URL from the baseURL and path.
        guard var urlBuilder = URLComponents(string: baseURL + path) else {
            throw APIError.invalidURL(urlStr: baseURL + path) // If URL is invalid, throw error.
        }

        // If the task contains query parameters, append them to the URL.
        if !task.queryItem.isEmpty {
            urlBuilder.queryItems = task.queryItem
            // Percent-encode the query to replace "+" with "%2B" (important for certain characters).
            urlBuilder.percentEncodedQuery = urlBuilder.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }

        // Ensure that the final URL is valid, else throw error.
        guard let url = urlBuilder.url else {
            throw APIError.invalidURL(urlStr: urlBuilder.url?.absoluteString ?? "")
        }

        // Create a URLRequest from the valid URL.
        var urlRequest = URLRequest(url: url)

        // Set the HTTP headers from the `header` property.
        urlRequest.allHTTPHeaderFields = header

        // Set the HTTP method (e.g., GET, POST, etc.) based on the `method` property.
        urlRequest.httpMethod = method.rawValue.uppercased()

        // If the `task` contains URL parameters (form data), encode them and add them to the request.
        if let urlParams = task.urlParams {
            let jsonString = urlParams.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast() // Concatenate key-value pairs.
            if let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false) {
                urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // Set content type.
                urlRequest.httpBody = jsonData // Add the encoded data to the body.
            }
        }

        // If the `task` contains JSON body parameters, serialize them into Data and set as the request body.
        if let bodyParams = task.jsonBody {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
        }

        // If the `task` contains multipart/form-data, set the appropriate content type and body.
        if let multiPart = task.formData {
            urlRequest.addValue(multiPart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type") // Set multipart content type.
            urlRequest.httpBody = multiPart.httpBody // Set the multipart form data as the body.
        }

#if IS_DEBUG_MODE
        print(urlRequest.curlString)
#endif

        // Return the final URLRequest.
        return urlRequest
    }
}
