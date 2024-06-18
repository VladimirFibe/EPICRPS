import UIKit

final class RoundBackgroundView: UIView {
    private let backgroundImage = UIImageView()
    private let upHandImage = UIImageView()
    private let downHandImage = UIImageView()
    private let titleLabel = UILabel()
    private let roundLabel = UILabel()
    private let progressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImage()
        setupUpHandImage()
        setupDownHandImage()
        setupTitleLabel()
        setupRoundLabel()
        setupProgressLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with recent: Recent) {
        upHandImage.image = UIImage(named: recent.upImage)
        downHandImage.image = UIImage(named: recent.downImage)
        if recent.currentCount == 3 {
            roundLabel.text = "You Win!!!"
        } else if recent.playerCount == 3 {
            roundLabel.text = "You Lose"
        } else {
            roundLabel.text = String(recent.round + 1)
        }
        titleLabel.text = recent.status.title
        progressLabel.text = "\(recent.playerCount) - \(recent.currentCount)"
    }
}
// MARK: - Setup Views
extension RoundBackgroundView {
    private func setupBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.image = .background
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUpHandImage() {
        addSubview(upHandImage)
        upHandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upHandImage.topAnchor.constraint(equalTo: topAnchor),
            upHandImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        ])
    }
    
    private func setupDownHandImage() {
        addSubview(downHandImage)
        downHandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downHandImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            downHandImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = RubikFont.bold.splashTitle
        titleLabel.textColor = .winText
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupRoundLabel() {
        addSubview(roundLabel)
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        roundLabel.font = RubikFont.bold.splashTitle
        roundLabel.textColor = .white
        NSLayoutConstraint.activate([
            roundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ])
    }
    
    private func setupProgressLabel() {
        addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.font = RubikFont.bold.splashTitle
        progressLabel.textColor = .white
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
    }
}
