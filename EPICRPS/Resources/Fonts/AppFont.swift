//
//  AppFont.swift
//  EPICRPS
//
//  Created by WWDC on 13.06.2024.
//

import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    var splashTitle: UIFont { apply(size: 30) }
    var size14: UIFont { apply(size: 14) }
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
