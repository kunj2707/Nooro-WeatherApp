import Foundation

/// An extension to the `Double` type that adds a computed property for formatting double values as strings.
extension Double {
    /// Converts the `Double` value to a formatted string with one decimal place.
    /// - Returns: A string representation of the `Double` value rounded to one decimal place.
    var stringValue: String {
        return String(format: "%.1f", self)
    }
}
