import UIKit

final class FightResultView: UIView {
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with recent: Recent) {
        let isVictory = recent.currentCount > recent.playerCount
        FileStorage.downloadImage(id: recent.currentId, link: recent.currentAvatar) { image in
            self.avatarImageView.image = image?.circleMasked
        }
        
        resultLabel.text = isVictory ? "You Win" : "You Lose"
        resultLabel.textColor = isVictory ? .xFFB24C : .x1B122E
        scoreLabel.text = "\(recent.playerCount) - \(recent.currentCount)"
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
        resultLabel.text = "You win"
        resultLabel.font = RubikFont.bold.size21
    }
    
    private func setupScoreLabel() {
        mainStackView.addArrangedSubview(scoreLabel)
        scoreLabel.text = "0 - 3"
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
    FightResultView()
}
