import UIKit

final class FightResultView: UIView {
    private let isVictory: Bool
    private let score: String
    private let avatar: UIImage
    
    private let radius = 39.0
    private let borderWidth = 50.0
    private var cornerRadius: Double { radius + borderWidth }

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
        setupMainStackView()
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 800, height: 1000)
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    public func configure(with target: Any?, homeAction: Selector, repeatAction: Selector) {
        homeButton.addTarget(target, action: homeAction, for: .primaryActionTriggered)
        repeatButton.addTarget(target, action: repeatAction, for: .primaryActionTriggered)
    }
}
// MARK: Setup Views
extension FightResultView {
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
    FightResultView(isVictory: true, score: "3 - 1", avatar: .avatar)
}
