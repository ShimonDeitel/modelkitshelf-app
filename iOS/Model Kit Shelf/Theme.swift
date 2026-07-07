import SwiftUI

enum Theme {
    static let accent = Color(red: 0.2392, green: 0.6471, blue: 0.8510)
    static let background = Color(red: 0.0549, green: 0.1059, blue: 0.1412)
    static let card = Color(red: 0.0824, green: 0.1490, blue: 0.2039)
    static let textPrimary = Color(red: 0.9176, green: 0.9569, blue: 0.9804)
    static let textMuted = Color(red: 0.5608, green: 0.7216, blue: 0.8000)

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let labelFont = Font.system(.caption, design: .rounded).weight(.semibold)
}
