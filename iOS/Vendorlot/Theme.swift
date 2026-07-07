import SwiftUI

/// hand-painted sign yellow with weathered wood brown
enum Theme {
    static let accent = Color(red: 0.8314, green: 0.6275, blue: 0.0902)
    static let accentSecondary = Color(red: 0.4196, green: 0.2588, blue: 0.1490)
    static let background = Color(red: 0.0941, green: 0.0784, blue: 0.0627)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
