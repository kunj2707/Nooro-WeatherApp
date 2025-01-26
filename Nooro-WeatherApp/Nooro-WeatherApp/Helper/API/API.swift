import Foundation

/// Enum representing API endpoints for the application.
enum API {
    /// Endpoint for fetching weather data with a given query (e.g., city name or location).
    case getWeather(quary: String)
}

/// Extension to conform `API` to `APIProtocol`, defining its properties and behavior.
extension API: APIProtocol {
    
    /// The base URL for the API. It is fetched dynamically from the configuration file.
    /// - Returns: The base URL as a string.
    /// - Note: If an error occurs while fetching the `BASE_URL`, an alert is displayed, and an empty string is returned.
    var baseURL: String {
        do {
            return try "https://" + Configuration.value(for: "BASE_URL")
        } catch {
            AppAlert.showAlert(msg: error.localizedDescription)
            return ""
        }
    }
    
    /// The specific path for the API endpoint.
    /// - Returns: The path as a string.
    var path: String {
        switch self {
        case .getWeather:
            return "/v1/current.json" // Path for fetching current weather data.
        }
    }
    
    /// The HTTP method to be used for the API request.
    /// - Returns: An `APIMethod` enum value (e.g., `.get` for GET requests).
    var method: APIMethod {
        switch self {
        case .getWeather:
            return .get // Using the GET method for fetching data.
        }
    }
    
    /// The task configuration for the API request.
    /// - Returns: An `ABRequest` representing the type of request (e.g., query parameters or plain request).
    /// - Note: If an error occurs while fetching the API key, an alert is displayed, and a plain request is returned.
    var task: ABRequest {
        switch self {
        case .getWeather(let quary):
            do {
                return .queryString([
                    "q": quary, // Query parameter for the search query.
                    "key": try Configuration.value(for: "API_KEY") // API key for authentication.
                ])
            } catch {
                AppAlert.showAlert(msg: error.localizedDescription)
                return .requestPlain // Fallback to a plain request in case of error.
            }
        }
    }
    
    /// The HTTP headers for the API request.
    /// - Returns: A dictionary containing header key-value pairs.
    var header: [String : String] {
        return [
            "Content-Type": "application/json" // Ensures the request body is in JSON format.
        ]
    }
}
