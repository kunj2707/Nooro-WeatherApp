import Foundation

/// A protocol that defines the contract for network-related services.
protocol NetworkService {
    /// Fetches weather data for a specified query (e.g., city name or location).
    /// - Parameter quary: The search query used to retrieve weather information.
    /// - Returns: A `CityWeatherModel` containing the weather data for the queried location.
    /// - Throws: An error if the network request fails or if data parsing is unsuccessful.
    func fetchWeather(quary: String) async throws -> CityWeatherModel
}

