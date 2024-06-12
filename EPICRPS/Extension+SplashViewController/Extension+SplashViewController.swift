//
//  Extension+SplashViewController.swift
//  EPICRPS
//
//  Created by Pavel Kostin on 12.06.2024.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(image: UIImage) {
        self.init()
        self.setImage(image, for: .normal)
    }
}


extension UIImageView {
    
    convenience init(image: UIImage) {
        self.init()
        self.image = image
        self.contentMode = .scaleAspectFit
    }
}

extension UIStackView {
    
    convenience init(aligment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        self.init()
        self.alignment = aligment
        self.axis = axis
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Resources

enum Resources {
    enum Strings {
        static let epicLable = "EPIC RPS"
    }
}


