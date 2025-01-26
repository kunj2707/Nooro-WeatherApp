import Foundation

/// A property wrapper for optional dependency injection, allowing automatic resolution of a service instance if it exists.
/// If the dependency cannot be resolved, the `wrappedValue` remains `nil` instead of causing a crash.
@propertyWrapper
public class OptionalInjected<Service> {
    // MARK: - Properties
    
    /// The resolved service instance, or `nil` if the dependency cannot be resolved.
    public var wrappedValue: Service?

    // MARK: - Initializer
    
    /// Initializes the property wrapper and attempts to resolve the dependency using the provided resolver.
    /// - Parameters:
    ///   - resolver: The dependency resolver used to resolve the service. Defaults to `Resolver.default`.
    ///   - tag: An optional tag to differentiate between multiple registrations of the same service type.
    public init(resolver: Resolver = .default, tag: String? = nil) {
        // Attempt to resolve the service of the specified type from the resolver.
        // If resolution fails, `wrappedValue` is set to `nil`.
        wrappedValue = resolver.resolve(type: Service.self, tag: tag)
    }
}
