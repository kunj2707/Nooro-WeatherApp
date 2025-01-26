import Foundation

// MARK: - Storable
/// A protocol that represents an object that can be stored and uniquely identified.
protocol Storable {
    /// A unique identifier for the object.
    var identifire: UUID { get }
}

// MARK: - Container
/// A generic container class that conforms to the `Storable` protocol.
/// It stores a factory closure for creating instances of a generic type `T`.
/// - Note: This is useful for dependency injection or object management.
class Container<T>: Storable {
    /// A unique identifier for the container instance.
    var identifire: UUID = .init()
    
    /// A factory closure for creating instances of type `T`.
    var factory: () -> T

    /// Initializes the container with a factory closure.
    /// - Parameter factory: A closure that returns an instance of type `T`.
    init(factory: @escaping () -> T) {
        self.factory = factory
    }
}
