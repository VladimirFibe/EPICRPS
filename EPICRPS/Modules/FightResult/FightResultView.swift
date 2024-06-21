import UIKit

final class FightResultView: UIView {
    private let isVictory: Bool
    private let score: String
    private let avatar: UIImage
    
    private let radius = 39.0
    private let borderWidth = 50.0
    private var cornerRadius: Double { radius + borderWidth }
    private lazy var backgroundView = EllipticalRadialGradientView(isVictory)
    private let mainStackView = UIStackView()
    private let buttonStackView = UIStackView()
    private let avatarImageView = UIImageView()
    private let resultLabel = UILabel()
    private let scoreLabel = UILabel()
    private let homeButton = UIButton(type: .system)
    private let repeatButton = UIButton(type: .system)
    
    init(isVictory: Bool, score: String, avatar: UIImage) {
        self.isVictory = isVictory
        self.score = score
        self.avatar = avatar
        super.init(frame: .zero)
        setupBackgroundView(with: isVictory)
        setupMainStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with target: Any?, homeAction: Selector, repeatAction: Selector) {
        homeButton.addTarget(target, action: homeAction, for: .primaryActionTriggered)
        repeatButton.addTarget(target, action: repeatAction, for: .primaryActionTriggered)
    }
}
// MARK: Setup Views
extension FightResultView {
    
    private func setupBackgroundView(with isVictory: Bool) {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupMainStackView() {
        addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        setupAvatarImageView()
        mainStackView.setCustomSpacing(26 + borderWidth, after: avatarImageView)
        setupResultLabel()
        mainStackView.setCustomSpacing(6, after: resultLabel)
        setupScoreLabel()
        mainStackView.setCustomSpacing(34, after: scoreLabel)
        setupButtonStackView()
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupAvatarImageView() {
        mainStackView.addArrangedSubview(avatarImageView)
        avatarImageView.image = .avatar
        let externalBorder = CALayer()
        let borderColor = UIColor.x2B2870.cgColor
        externalBorder.frame = CGRect(x: -borderWidth, y: -borderWidth, width: 2 * cornerRadius, height: 2 * cornerRadius)
        externalBorder.borderColor = borderColor
        externalBorder.borderWidth = borderWidth
        externalBorder.cornerRadius = cornerRadius
        avatarImageView.layer.insertSublayer(externalBorder, at: 0)
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 2 * radius),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ])
    }
    
    private func setupResultLabel() {
        mainStackView.addArrangedSubview(resultLabel)
        resultLabel.text = isVictory ? "You Win" : "You Lose"
        resultLabel.textColor = isVictory ? .xFFB24C : .x1B122E
        resultLabel.font = RubikFont.bold.size21
    }
    
    private func setupScoreLabel() {
        mainStackView.addArrangedSubview(scoreLabel)
        scoreLabel.textColor = .systemBackground
        scoreLabel.text = score
        scoreLabel.font = RubikFont.medium.size41
    }
    
    private func setupButtonStackView() {
        mainStackView.addArrangedSubview(buttonStackView)
        buttonStackView.spacing = 42
        setupHomeButton()
        setupRepeatButton()
    }
    
    private func setupHomeButton() {
        buttonStackView.addArrangedSubview(homeButton)
        homeButton.setImage(.homeButton, for: [])
    }
    
    private func setupRepeatButton() {
        buttonStackView.addArrangedSubview(repeatButton)
        repeatButton.setImage(.repeatButton, for: [])
    }
}

@available(iOS 17.0, *)
#Preview {
    FightResultView(isVictory: false, score: "3 - 1", avatar: .avatar)
}

final class EllipticalRadialGradientView: UIView {
    
    private var isGradientDrawn = false
    
    private var gradientLayer: EllipticalGradientLayer?
    
    init(_ isVictory: Bool) {
        super.init(frame: .zero)
        if isVictory {
            gradientLayer = EllipticalGradientLayer(
                innerColor: UIColor.x2D2599.cgColor,
                outsideColor: UIColor.x656DF4.cgColor
            )
        } else {
            gradientLayer = EllipticalGradientLayer(
                innerColor: UIColor.xFFB600.cgColor,
                outsideColor: UIColor.xEE413C.cgColor
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isGradientDrawn && bounds != .zero {
            makeGradient()
        }
    }
    
    private func makeGradient() {
        isGradientDrawn = true
        guard let gradientLayer else { return }
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.setNeedsDisplay()
    }
}

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

