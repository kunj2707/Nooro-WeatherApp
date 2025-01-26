import Foundation

/// A model representing the weather information of a city.
struct CityWeatherModel: Codable, Equatable {
    let location: LocationModel
    let current: CurrentWeatherModel
}

/// A model representing the current weather details of a city.
struct CurrentWeatherModel: Codable, Equatable {
    let tempC: Double
    let condition: WeatherConditionModel
    let humidity: Int
    let feelslikeC: Double
    let uv: Double
    
    // MARK: - CodingKeys
    
    /// Maps JSON keys to Swift property names for decoding.
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition, humidity
        case feelslikeC = "feelslike_c"
        case uv
    }
}

/// A model representing the location of the city.
struct LocationModel: Codable, Equatable {
    let name: String
    
    // MARK: - CodingKeys
    
    /// Maps JSON keys to Swift property names for decoding.
    enum CodingKeys: String, CodingKey {
        case name
    }
}

/// A model representing the condition of the weather, including the weather icon URL.
struct WeatherConditionModel: Codable, Equatable {
    let iconURL: String
    
    /// A computed property that modifies the icon URL to use a larger icon size.
    /// - Returns: A valid `URL` with a larger icon size or an empty file URL if invalid.
    var validImageURL: URL? {
        // Replaces "64x64" in the original URL with "128x128" to use a larger icon.
        let largerIconURL = iconURL.replacingOccurrences(of: "64x64", with: "128x128")
        return URL(string: "https:\(largerIconURL)") ?? .init(fileURLWithPath: "")
    }
    
    // MARK: - CodingKeys
    
    /// Maps JSON keys to Swift property names for decoding.
    enum CodingKeys: String, CodingKey {
        case iconURL = "icon"
    }
}
