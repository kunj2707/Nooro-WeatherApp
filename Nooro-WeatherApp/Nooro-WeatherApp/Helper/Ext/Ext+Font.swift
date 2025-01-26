import SwiftUI

extension Font {
    // MARK: - Headings
    /// Fonts for headings, used to define the hierarchy of titles in the app.
    /// These styles are typically bold or semi-bold to stand out.
    
    /// A large title, used for primary headers or prominent titles. Example: Screen titles.
    static let largeTitle = poppins(.bold, size: 34)
    /// The main title style, slightly smaller than `largeTitle`. Example: Section headers.
    static let title = poppins(.semiBold, size: 28)
    /// A secondary title style, used for subtitles or smaller headers.
    static let title2 = poppins(.semiBold, size: 22)
    /// A tertiary title style, suitable for smaller titles or subheadings.
    static let title3 = poppins(.medium, size: 20)
    
    // MARK: - Body Text
    /// Fonts for body text, used for most of the content in the app.
    
    /// A larger body text style. Example: Primary paragraphs or emphasized content.
    static let bodyLarge = poppins(.regular, size: 17)
    /// A medium-sized body text style. Example: Secondary text or general content.
    static let bodyMedium = poppins(.regular, size: 15)
    /// A smaller body text style. Example: Supplementary text or minor details.
    static let bodySmall = poppins(.regular, size: 13)
    
    // MARK: - Captions
    /// Fonts for captions, used for smaller, descriptive text such as labels or annotations.
    
    /// Standard caption style. Example: Labels for UI elements or small notes.
    static let caption = poppins(.regular, size: 12)
    /// A secondary caption style, slightly smaller than `caption`. Example: Supporting text for minor elements.
    static let caption2 = poppins(.regular, size: 11)
    
    // MARK: - Others
    /// Miscellaneous font styles for specific use cases.
    
    /// A callout style, used for text that needs to stand out without being as bold as a heading.
    /// Example: Featured notes or announcements.
    static let callout = poppins(.light, size: 13)
    /// A footnote style, used for the smallest text in the app.
    /// Example: Disclaimers, legal text, or metadata.
    static let footnote = poppins(.regular, size: 10)
    
    // MARK: - Custom Font Helper
    /// A helper method to create a custom font using the Poppins font family.
    /// - Parameters:
    ///   - font: The font variant to use (e.g., `.bold`, `.regular`).
    ///   - size: The size of the font.
    /// - Returns: A `Font` object with the specified custom font and size.
    static func poppins(_ font: Theme.Fonts, size: CGFloat) -> Font {
        let screenWidth = UIScreen.main.bounds.width
        switch screenWidth {
        case ..<375: // Small screens (e.g., iPhone SE)
            return .custom(font.rawValue, size: size * 0.8)
        case 375...440: // Medium screens (e.g., iPhone 13, 14, 15, 16)
            return .custom(font.rawValue, size: size)
        default: // Large screens (e.g., iPads)
            return .custom(font.rawValue, size: size * 1.2)
        }
    }
}
