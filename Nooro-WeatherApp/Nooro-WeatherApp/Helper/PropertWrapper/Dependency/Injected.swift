import Foundation

/// A property wrapper for dependency injection, enabling automatic resolution of a service instance.
@propertyWrapper
public class Injected<Service> {
    // MARK: - Properties
    
    /// The resolved instance of the service.
    public var wrappedValue: Service

    // MARK: - Initializer
    
    /// Initializes the property wrapper and resolves the dependency using the provided resolver.
    /// - Parameters:
    ///   - resolver: The dependency resolver to use for resolving the service. Defaults to `Resolver.default`.
    ///   - tag: An optional tag to differentiate between multiple registrations of the same service type.
    public init(resolver: Resolver = .default, tag: String? = nil) {
        // Attempt to resolve the service of the specified type from the resolver.
        guard let value = resolver.resolve(type: Service.self, tag: tag) else {
            // If resolution fails, crash with a detailed error message.
            fatalError("Unable to resolve type \(String(describing: Service.self))")
        }
        // Assign the resolved service to the wrappedValue.
        wrappedValue = value
    }
}
