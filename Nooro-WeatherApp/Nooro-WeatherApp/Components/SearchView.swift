import SwiftUI

struct SearchView: View {
    // MARK: - Private Properties
    
    // MARK: - State Properties
    @Binding var searchText: String
    
    // MARK: - Binding Properties
    
    // MARK: - Properties
    var onSerach: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Theme.Spacing.medium) {
            TextField("Search Location", text: $searchText)
            
            Button {
                onSerach()
                searchText = ""
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(Theme.Colors.textTertiary)
            }
        }
        .font(.bodyLarge)
        .padding(.horizontal, Theme.Spacing.medium)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                .fill(Theme.Colors.secondary)
        )
    }
    
    // MARK: - Private Functions
}


#Preview {
    SearchView(searchText: .constant("")) {}
        .padding(.horizontal, Theme.Spacing.medium)
}
