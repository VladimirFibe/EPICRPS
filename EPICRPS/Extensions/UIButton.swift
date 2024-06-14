//
//  UIButton.swift
//  EPICRPS
//
//  Created by Семен Шевчик on 12.06.2024.
//

import UIKit

extension UIButton {
    convenience init(nameFigure: String) {
        self.init()
        self.setImage(UIImage(named: nameFigure), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
