import Foundation

/// A concrete implementation of the `NetworkService` protocol for handling network requests.
final class NetworkManager: NetworkService {
    
    /// Fetches weather data for a given query (e.g., city name or location).
    /// - Parameter quary: The search query to fetch weather data for.
    /// - Returns: A `CityWeatherModel` object containing the weather information for the queried location.
    /// - Throws: An error if the network request fails or data parsing is unsuccessful.
    func fetchWeather(quary: String) async throws -> CityWeatherModel {
        // Use the APIService to perform a request for the weather data
        // based on the provided query and return the resulting model.
        return try await APIService.request(API.getWeather(quary: quary))
    }
}
