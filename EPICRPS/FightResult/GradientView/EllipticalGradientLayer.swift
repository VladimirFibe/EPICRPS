//
//  GradientView.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 12.06.2024.
//

import UIKit

final class EllipticalGradientLayer: CALayer {

    private var innerColor: CGColor?
    private var outsideColor: CGColor?

    init(innerColor: CGColor, outsideColor: CGColor) {
        super.init()
        
        self.innerColor = innerColor
        self.outsideColor = outsideColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(in ctx: CGContext) {
        
        let colors = [innerColor, outsideColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]

        /// CGGradient — это Core Graphics объект, который описывает градиент. Градиент определяется набором цветов и их расположениями.
        /// - colorsSpace:  цветовое пространство, в котором будут интерполироваться цвета градиента. По дефолту стандартное цветового пространства устройства
        /// - colors — массив, содержащий цвета градиента.
        /// - locations — массив значений, указывающих расположение каждого цвета в градиенте. Значения в массиве должны быть в диапазоне от 0.0 до 1.0, где 0.0 представляет начало градиента, а 1.0 — конец градиента.
        guard
            let gradient = CGGradient(
                colorsSpace: colorSpace,
                colors: colors as CFArray,
                locations: colorLocations
            )
        else { return }

        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        
        // startRadius и endRadius определяют размер innerColor
        let startRadius: CGFloat = 0
        let endRadius: CGFloat = max(bounds.size.width, bounds.size.height) / 2

        ctx.saveGState()
        ctx.translateBy(x: center.x, y: center.y)
        ctx.scaleBy(x: bounds.size.width / bounds.size.height, y: 1.0)
        ctx.translateBy(x: -center.x, y: -center.y)
        
        /// drawRadialGradient — это метод CGContext, который рисует радиальный градиент, используя указанные параметры.
        /// - gradient - определяет цвета и расположения градиента.
        /// - startCenter -  начальная точка центра градиента.
        /// - startRadius -  радиус начальной окружности градиента. Обычно 0, чтобы градиент начинался из центра.
        /// - endCenter  - конечная точка центра градиента. Для радиального градиента, который мы рисуем, начальная и конечная точки центра обычно совпадают
        /// - endRadius -  радиус конечной окружности градиента. Он определяет, где градиент закончится.
        ctx.drawRadialGradient(gradient,
                               startCenter: center, startRadius: startRadius,
                               endCenter: center, endRadius: endRadius,
                               options: .drawsAfterEndLocation)
        ctx.restoreGState()
    }
}
