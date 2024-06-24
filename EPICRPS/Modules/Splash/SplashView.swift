import UIKit

final class SplashView: UIView {
    private let titleLabel = UILabel()
    private let maleHandView = UIImageView()
    private let femaleHandView = UIImageView()
    private let startButton = UIButton(type: .system)
    private let resultsButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupMaleHandView()
        setupFemaleHandView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with target: Any?, startAction: Selector, resultsAction: Selector) {
        startButton.addTarget(target, action: startAction, for: .primaryActionTriggered)
        resultsButton.addTarget(target, action: resultsAction, for: .primaryActionTriggered)
    }
}
// MARK: Setup Views
extension SplashView {
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "EPIC RPS"
        titleLabel.font = RubikFont.bold.size30
        titleLabel.textColor = .xFBC399
        titleLabel.shadowColor = .xEA9975
        titleLabel.shadowOffset = CGSize(width: 2, height: 2)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
        ])
    }
    
    private func setupMaleHandView() {
        addSubview(maleHandView)
        maleHandView.translatesAutoresizingMaskIntoConstraints = false
        maleHandView.image = .maleHand
        NSLayoutConstraint.activate([
            maleHandView.widthAnchor.constraint(equalToConstant: 352.26),
            maleHandView.heightAnchor.constraint(equalToConstant: 88.62),
            maleHandView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 42),
            maleHandView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -55)
        ])
    }
    
    private func setupFemaleHandView() {
        addSubview(femaleHandView)
        femaleHandView.translatesAutoresizingMaskIntoConstraints = false
        femaleHandView.image = .femaleHand
        NSLayoutConstraint.activate([
            femaleHandView.widthAnchor.constraint(equalToConstant: 380.99),
            femaleHandView.heightAnchor.constraint(equalToConstant: 83.03),
            femaleHandView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -24),
            femaleHandView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 55)
        ])
    }
    
    private func setupButtons() {
        addSubview(startButton)
        addSubview(resultsButton)
        startButton.setImage(.start, for: [])
        resultsButton.setImage(.results, for: [])
        startButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            resultsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10)
        ])
    }
}
