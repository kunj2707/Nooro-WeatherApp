import Foundation

/// A service locator and dependency injection container.
public class Resolver {
    
    // MARK: - Key
    
    /// A struct used as a unique key for registering and resolving dependencies.
    /// It is composed of the type's `ObjectIdentifier` and an optional `tag` for differentiation.
    public struct Key: Hashable {
        var identifier: ObjectIdentifier
        var tag: String?
    }

    // MARK: - Properties
    
    /// The default instance of the `Resolver` for global usage.
    public static let `default` = Resolver()

    /// A dictionary storing registered dependencies using `Key` as the key and `Storable` as the value.
    private var registeries = [Key: Storable]()

    // MARK: - Registration
    
    /// Registers a type `T` in the resolver with an optional tag and factory closure for creating the instance.
    /// - Parameters:
    ///   - type: The type of the service to be registered.
    ///   - tag: An optional tag to differentiate multiple registrations of the same type.
    ///   - factory: A factory closure that returns an instance of type `T`.
    public func register<T>(type: T.Type, tag: String? = nil, factory: @autoclosure @escaping () -> T) {
        let key = Key(
            identifier: ObjectIdentifier(type), // Generate a unique identifier for the type.
            tag: tag
        )
        let container = Container(factory: factory) // Create a container to hold the factory.
        registeries[key] = container // Store the container in the registry.
    }

    // MARK: - Resolution
    
    /// Resolves an instance of type `T` from the resolver.
    /// - Parameters:
    ///   - type: The type of the service to resolve.
    ///   - tag: An optional tag to resolve a specific registration of the type.
    /// - Returns: The resolved instance of type `T`, or `nil` if not found.
    public func resolve<T>(type: T.Type, tag: String? = nil) -> T? {
        let key = Key(
            identifier: ObjectIdentifier(type), // Create a unique key using the type's identifier.
            tag: tag
        )

        // Retrieve the container associated with the key and resolve the instance.
        guard let container = registeries[key] as? Container<T> else {
            return nil // Return `nil` if no matching container is found.
        }

        // Return the resolved instance using the factory stored in the container.
        return container.factory()
    }

    // MARK: - Unregistration
    
    /// Unregisters a type `T` from the resolver, removing it from the registry.
    /// - Parameters:
    ///   - type: The type to unregister.
    ///   - tag: An optional tag to remove a specific registration of the type.
    public func unregister<T>(type: T.Type, tag: String? = nil) {
        let key = Key(
            identifier: ObjectIdentifier(type), // Create a unique key for the type.
            tag: tag
        )

        // Remove the container associated with the key from the registry.
        registeries.removeValue(forKey: key)
    }
}
