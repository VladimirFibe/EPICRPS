import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    var splashTitle: UIFont { apply(size: 30) }
    var size13: UIFont { apply(size: 13) }
    var size14: UIFont { apply(size: 14) }
    var size16: UIFont { apply(size: 16) }
    var size18: UIFont { apply(size: 18) }
}

extension AppFontProtocol {
    func apply(size value: CGFloat) -> UIFont {
        UIFont.init(name: rawValue, size: value) ?? .systemFont(ofSize: value)
    }
}

enum RubikFont: String, AppFontProtocol {
    case regular = "Rubik-Regular"
    case bold = "Rubik-Bold"
    case medium = "Rubik-Medium"
}
