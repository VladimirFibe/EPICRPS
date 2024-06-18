import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    var size12: UIFont { apply(size: 12) }
    var size13: UIFont { apply(size: 13) }
    var size14: UIFont { apply(size: 14) }
    var size16: UIFont { apply(size: 16) }
    var size18: UIFont { apply(size: 18) }
    var size21: UIFont { apply(size: 21) }
    var splashTitle: UIFont { apply(size: 30) }
    var size41: UIFont { apply(size: 41) }
    var size56: UIFont { apply(size: 56)}
}

extension AppFontProtocol {
    private func apply(size value: CGFloat) -> UIFont {
        UIFont.init(name: rawValue, size: value) ?? .systemFont(ofSize: value)
    }
}

enum RubikFont: String, AppFontProtocol {
    case regular = "Rubik-Regular"
    case bold = "Rubik-Bold"
    case medium = "Rubik-Medium"
}
