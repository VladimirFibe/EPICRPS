//
//  EllipticalRadialGradientView.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 12.06.2024.
//

import UIKit

final class EllipticalRadialGradientView: UIView {
    
    private var isGradientDrawn = false
    
    private var gradientLayer: EllipticalGradientLayer?
    
    init(_ innerColor: CGColor, _ outsideColor: CGColor) {
        super.init(frame: .zero)
        gradientLayer = EllipticalGradientLayer(
            innerColor: innerColor,
            outsideColor: outsideColor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isGradientDrawn && self.bounds != .zero {
            self.makeGradient()
            self.isGradientDrawn = true
        }
    }
    
    private func makeGradient() {
        guard let gradientLayer = gradientLayer else { return }
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.setNeedsDisplay()
    }
}
