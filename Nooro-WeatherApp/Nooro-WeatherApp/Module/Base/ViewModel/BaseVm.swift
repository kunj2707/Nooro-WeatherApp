import Foundation

@MainActor
class BaseVm: ObservableObject {
    // MARK: - Dependencies
    @Injected var networkServices: NetworkService
}
