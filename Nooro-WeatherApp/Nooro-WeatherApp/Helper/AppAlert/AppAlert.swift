import UIKit

/// A utility enum that provides various alert and UI presentation functions for iOS applications
public enum AppAlert {
    /// Creates and configures a base UIAlertController with custom fonts for title and message
    /// - Parameters:
    ///   - title: The title text to display in the alert
    ///   - titleFont: Custom font for the title (defaults to system font)
    ///   - msg: Optional message text to display below the title
    ///   - msgFont: Custom font for the message (defaults to system font)
    /// - Returns: Configured UIAlertController
    private static func alert(
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold),
        msg: String?,
        msgFont: UIFont = .systemFont(ofSize: 13, weight: .regular)
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        // Configure custom attributed string for title
        var mutableTitleString = NSMutableAttributedString()
        mutableTitleString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: titleFont])
        alert.setValue(mutableTitleString, forKey: "attributedTitle")
        
        // Configure custom attributed string for message
        var mutableMessageString = NSMutableAttributedString()
        mutableMessageString = NSMutableAttributedString(string: msg ?? "", attributes: [NSAttributedString.Key.font: msgFont])
        alert.setValue(mutableMessageString, forKey: "attributedMessage")
        return alert
    }
    
    /// Retrieves the topmost view controller in the application's window hierarchy
    /// - Returns: The topmost UIViewController, if available
    public static func getTopMostVc() -> UIViewController? {
        if var topController = UIApplication.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        
        return UIApplication.keyWindow?.rootViewController
    }
    
    /// Shows an alert with multiple customizable buttons and handles button taps
    /// - Parameters:
    ///   - title: Alert title (defaults to app name)
    ///   - titleFont: Custom font for title
    ///   - msg: Optional message text
    ///   - msgFont: Custom font for message
    ///   - options: Variable number of button titles
    ///   - btnStyle: Variable number of button styles (must match options count)
    ///   - completion: Callback with selected button index
    public static func showAlert(title: String = Bundle.main.appName,
                                 titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold),
                                 msg: String? = nil,
                                 msgFont: UIFont = .systemFont(ofSize: 13, weight: .regular),
                                 options: String...,
                                 btnStyle: UIAlertAction.Style...,
                                 completion: @escaping ((Int) -> Void)) {
        let alert = alert(title: title, titleFont: titleFont, msg: msg, msgFont: msgFont)
        
        // Add actions for each option
        for (index, option) in options.enumerated() {
            let action = UIAlertAction(title: option,
                                       style: btnStyle[index],
                                       handler: { _ in
                completion(index)
            })
            
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            getTopMostVc()?.present(alert, animated: true)
        }
    }
    
    /// Shows a simple alert with a single button (typically "OK")
    public static func showAlert(
        title: String = Bundle.main.appName,
        titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold),
        msg: String? = nil,
        msgFont: UIFont = .systemFont(ofSize: 13, weight: .regular),
        buttonText: String? = "Ok",
        complition: (() -> Void)? = nil
    ) {
        showAlert(title: title,
                  titleFont: titleFont,
                  msg: msg,
                  msgFont: msgFont,
                  options: buttonText ?? "Ok",
                  btnStyle: .default) { option in
            switch option {
            case 0: complition?()
            default: break
            }
        }
    }
}
