import SwiftUI

// MARK: - Theme
/// `Theme` acts as the central design system for the app.
/// It contains definitions for colors, fonts, and spacing, ensuring a cohesive design language.
public enum Theme {
    // MARK: - AppColor
    /// `AppColor` holds the color palette used throughout the app.
    /// Define all reusable colors here for consistency.
    public enum Colors {
        // MARK: - Primary Colors
        /// The primary color of the app (e.g., for buttons, headers, or main accents).
        public static let primary = Color.black
        
        /// A secondary color (e.g., for secondary buttons or accents).
        public static let secondary = Color.COLOR_F_2_F_2_F_2
        
        // MARK: - Background Colors
        /// A background color that adapts to light/dark mode.
        public static let background = Color.white
        
        /// A secondary background color (e.g., for cards or list items).
        public static let secondaryBackground = Color(UIColor.lightGray)
        
        /// A tertiary background color (e.g., subtle backgrounds for separators or borders).
        public static let tertiaryBackground = Color.white
        
        // MARK: - Text Colors
        /// The primary text color for light/dark mode.
        public static let textPrimary = Color.black
        
        /// A secondary text color (e.g., for subtitles or less prominent text).
        public static let textSecondary = Color(UIColor.darkGray)
        
        /// A tertiary text color (e.g., for placeholders or disabled text).
        public static let textTertiary = Color(UIColor.lightGray)
    }
    
    // MARK: - Fonts
    /// `Fonts` defines all font styles used in the app.
    /// It also provides a method to register custom fonts programmatically.
    public enum Fonts: String, CaseIterable {
        // Font variants for the Poppins font family
        case thin = "Poppins-Thin"
        case bold = "Poppins-Bold"
        case light = "Poppins-Light"
        case black = "Poppins-Black"
        case medium = "Poppins-Medium"
        case regular = "Poppins-Regular"
        case semiBold = "Poppins-SemiBold"
        case extraBold = "Poppins-ExtraBold"
        case extraLight = "Poppins-ExtraLight"
        
        /// Registers all custom fonts from the Poppins family.
        /// This must be called during app initialization to ensure the fonts are available.
        public static func registerFonts() {
            Fonts.allCases.forEach { font in
                registerFont(bundle: .main, fontName: font.rawValue, fontExtension: "ttf")
            }
        }
        
        /// Helper method to register a custom font.
        /// - Parameters:
        ///   - bundle: The bundle where the font file is located.
        ///   - fontName: The name of the font file without the extension.
        ///   - fontExtension: The file extension of the font (e.g., "ttf").
        fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
            guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
            }
            
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
    
    // MARK: - Spacing
    /// `Spacing` provides standard spacing values for margins, padding, and gaps.
    /// It ensures consistent spacing throughout the app's UI.
    enum Spacing {
        // Base Spacings
        /// Extra small spacing (e.g., small gaps or minimal padding).
        public static let extraSmall: CGFloat = 4
        /// Small spacing (e.g., between UI components or for compact padding).
        public static let small: CGFloat = 8
        /// Medium spacing (e.g., standard padding or margins).
        public static let medium: CGFloat = 16
        /// Large spacing (e.g., section padding or larger gaps).
        public static let large: CGFloat = 32
        /// Extra large spacing (e.g., for grouping or major sections).
        public static let extraLarge: CGFloat = 64
        /// Ultra large spacing (e.g., for full-screen layouts or oversized padding).
        public static let ultraLarge: CGFloat = 128
        
        /// Calculates dynamic spacing based on the screen size.
        /// - Parameter base: The base spacing value to adjust.
        /// - Returns: The adjusted spacing value for the current device size.
        public static func dynamicSpacing(base: CGFloat) -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            switch screenWidth {
            case ..<375: // Small screens (e.g., iPhone SE)
                return base * 0.8
            case 375...414: // Medium screens (e.g., iPhone 13, 14)
                return base
            default: // Large screens (e.g., iPads)
                return base * 1.2
            }
        }
        
        /// Adjusts spacing dynamically based on accessibility settings.
        /// - Parameters:
        ///   - base: The base spacing value to adjust.
        ///   - isAccessibilityEnabled: A flag indicating if accessibility settings are active.
        /// - Returns: A spacing value that accommodates accessibility needs.
        public static func accessibleSpacing(base: CGFloat, isAccessibilityEnabled: Bool) -> CGFloat {
            isAccessibilityEnabled ? base * 1.5 : base
        }
    }
    
    // MARK: - CornerRadius
    /// `CornerRadius` provides standardized corner radius values
    /// to ensure consistent rounded corners throughout the app.
    public enum CornerRadius {
        /// Small radius for subtle rounding (e.g., buttons, cards).
        public static let small: CGFloat = 4
        /// Medium radius for moderately rounded elements (e.g., dialogs, input fields).
        public static let medium: CGFloat = 8
        /// Large radius for highly rounded elements (e.g., containers, modals).
        public static let large: CGFloat = 16
        /// Extra large radius for shapes that require significant rounding.
        public static let extraLarge: CGFloat = 24
        /// Full radius for pill-shaped or completely rounded elements.
        public static let full: CGFloat = 9999
    }
}
