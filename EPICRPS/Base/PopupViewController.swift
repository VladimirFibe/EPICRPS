import UIKit

class PopupViewController: UIViewController {
    let cardView = UIView()
    let stackView = UIStackView()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupCardView()
        setupStackView()
        setupButton()
    }
    
    private func setupCardView() {
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 23
        cardView.backgroundColor = .white
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupStackView() {
        cardView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 42
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .xEA9975
        config.baseForegroundColor = .xFCD9C3
        config.cornerStyle = .capsule
        var attributedTitle = AttributedString("OK")
        attributedTitle.font = RubikFont.bold.size16
        config.attributedTitle = attributedTitle
        button.configuration = config
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 134),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
