import SwiftUI

struct HomeView: View {
    // MARK: - Private Properties
    
    // MARK: - Objects
    @StateObject private var viewModel = HomeVm()
    
    // MARK: - State Properties
    @State private var searchText: String = ""
    
    // MARK: - Binding Properties
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: Theme.Spacing.medium) {
            SearchView(searchText: $searchText) {
                viewModel.fetchWeather(searchText)
            }
            
            switch viewModel.output {
            case .noData:
                nodataView(
                    title: "No City Selected",
                    description: "Please Search For A City"
                )
            case .loading:
                loadingView
            case .dataFetch:
                VStack {
                    Button {
                        viewModel.output = .detailView
                    } label: {
                        cityListView
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            case .detailView:
                cityDetailView
            case .error(let error):
                nodataView(
                    title: "No City Found",
                    description: error.localizedDescription
                )
            }
        }
        .padding(.horizontal, Theme.Spacing.medium)
        .task {
            if !UserDefaults.lastSearchedCityName.isEmpty {
                viewModel.fetchWeather(UserDefaults.lastSearchedCityName, isDetailShow: true)
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: Theme.Spacing.small) {
            ProgressView()
                .tint(Theme.Colors.secondaryBackground)
                .scaleEffect(1.5)
            
            Text("Data Fetching...")
                .font(.bodyMedium)
                .foregroundStyle(Theme.Colors.textPrimary)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    private var cityListView: some View {
        HStack(spacing: Theme.Spacing.medium) {
            VStack(alignment: .leading, spacing: Theme.Spacing.extraSmall) {
                Text(viewModel.cityWeather?.location.name ?? "")
                    .font(.title)
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .lineLimit(1)
                
                Text("\(viewModel.cityWeather?.current.tempC.stringValue ?? "") °")
                    .font(.poppins(.medium, size: 46))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            AsyncImage(url: viewModel.cityWeather?.current.condition.validImageURL) { image in
                image.image
            }
        }
        .padding(Theme.Spacing.medium)
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.secondary)
        .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.large))
    }
    
    private var cityDetailView: some View {
        VStack(spacing: Theme.Spacing.medium) {
            AsyncImage(url: viewModel.cityWeather?.current.condition.validImageURL) { image in
                image.image
            }
            
            VStack(spacing: Theme.Spacing.extraSmall) {
                HStack(spacing: Theme.Spacing.extraSmall) {
                    Text(viewModel.cityWeather?.location.name ?? "")
                        .font(.title)
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .lineLimit(1)
                    
                    Image(systemName: "location.fill")
                        .font(.title2)
                }
                
                Text("\(viewModel.cityWeather?.current.tempC.stringValue ?? "") °")
                    .font(.poppins(.medium, size: 46))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .lineLimit(1)
            }
            
            HStack(spacing: Theme.Spacing.medium) {
                makeDataCell(
                    title: "Humidity",
                    data: "\(viewModel.cityWeather?.current.humidity ?? 0)"
                )
                
                makeDataCell(
                    title: "UV",
                    data: viewModel.cityWeather?.current.uv.stringValue ?? ""
                )
                
                makeDataCell(
                    title: "Feels Like",
                    data: viewModel.cityWeather?.current.feelslikeC.stringValue ?? ""
                )
            }
            .padding(Theme.Spacing.medium)
            .background(Theme.Colors.secondary)
            .clipShape(RoundedRectangle(cornerRadius: Theme.CornerRadius.large))
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    // MARK: - Private Functions
    @ViewBuilder
    private func nodataView(title: String, description: String) -> some View {
        VStack(spacing: Theme.Spacing.extraSmall) {
            Text(title)
                .font(.title)
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text(description)
                .font(.bodyMedium)
                .foregroundStyle(Theme.Colors.textPrimary)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private func makeDataCell(title: String, data: String) -> some View {
        VStack(spacing: Theme.Spacing.extraSmall) {
            Text(title)
                .font(.bodyLarge)
                .foregroundStyle(Theme.Colors.textSecondary)
                .lineLimit(1)
            
            Text(data)
                .font(.bodyLarge)
                .foregroundStyle(Theme.Colors.textSecondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
