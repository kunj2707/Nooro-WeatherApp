import Foundation

// MARK: - TypeAlias

/// A type alias for a collection of cancellable tasks, represented as a `Set` of `TaskCancellable` objects.
/// This allows managing and cancelling multiple tasks at once.
typealias TaskBag = Set<TaskCancellable>

// MARK: - TaskCancellable

/// A class that wraps a task and provides functionality to cancel it when deinitialized.
/// This is used to manage cancellable tasks in a collection (e.g., `TaskBag`).
final class TaskCancellable: Hashable {
    
    // MARK: - Properties
    
    /// A unique identifier for each `TaskCancellable` instance. Used for hashability and equality comparison.
    private var id = UUID()
    
    /// The underlying task that this class wraps. It can be cancelled when needed.
    private var task: Task<Void, Never>

    // MARK: - Initializer
    
    /// Initializes a new `TaskCancellable` instance with the provided task.
    /// - Parameter task: The task to wrap and manage.
    init(task: Task<Void, Never>) {
        self.task = task
    }

    // MARK: - Deinitializer
    
    /// Cancels the wrapped task when the `TaskCancellable` instance is deinitialized.
    deinit {
        self.task.cancel() // Ensure the task is cancelled if it's no longer needed.
    }

    // MARK: - Hashable
    
    /// Conforms to `Hashable` to allow `TaskCancellable` objects to be inserted into collections like `Set`.
    static func == (lhs: TaskCancellable, rhs: TaskCancellable) -> Bool {
        // Two `TaskCancellable` instances are considered equal if their `id` values match.
        lhs.id == rhs.id
    }

    /// Computes the hash value of the `TaskCancellable` instance based on its `id`.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use `id` to ensure unique hashing.
    }
}

extension Task where Success == Void, Failure == Never {
    // MARK: - Task Extension
    
    /// A helper function to store a task in a `TaskCancellable` collection (`TaskBag`).
    /// - Parameter taskCancellable: The collection (e.g., `TaskBag`) to insert the cancellable task into.
    func store(in taskCancellable: inout Set<TaskCancellable>) {
        // Wrap the task in a `TaskCancellable` and insert it into the set.
        taskCancellable.insert(TaskCancellable(task: self))
    }
}
