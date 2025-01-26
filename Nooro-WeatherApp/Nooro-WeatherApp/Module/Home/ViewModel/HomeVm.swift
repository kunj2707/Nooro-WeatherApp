import Foundation

final class HomeVm: BaseVm {
    // MARK: - Published Properties
    @Published var output: Output = .noData
    @Published var cityWeather: CityWeatherModel?
    
    // MARK: - Properties
    private var bag = TaskBag()
    
    // MARK: - Enums
    enum Output {
        case noData
        case loading
        case dataFetch
        case detailView
        case error(any Error)
    }
    
    // MARK: - Functions
    func fetchWeather(_ quary: String, isDetailShow: Bool = false) {
        output = .loading
        Task {
            do {
                cityWeather = try await networkServices.fetchWeather(quary: quary)
                if cityWeather != nil {
                    UserDefaults.lastSearchedCityName = quary
                }
                output = isDetailShow ? .detailView : .dataFetch
            } catch {
                output = .error(error)
            }
        }.store(in: &bag)
    }
}
