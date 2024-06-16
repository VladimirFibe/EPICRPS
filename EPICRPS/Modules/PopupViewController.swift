import UIKit

class PopupViewController: UIViewController {
    let cardView = PopupView()

    let titleLabel: UILabel = {
        $0.text = "Введите имя игрока"
        $0.font = RubikFont.regular.size14
        $0.textColor = #colorLiteral(red: 0.5593419671, green: 0.5592260957, blue: 0.5556153059, alpha: 1)
        return $0
    }(UILabel())

    let saveButton: TripButton = {
        $0.setTitle("OK", for: [])
        return $0
    }(TripButton(type: .system))

    let rootStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 20
        return $0
    }(UIStackView())

    let titleStackView: UIStackView = {
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())

    let bodyStackView: UIStackView = {
        $0.spacing = 10
        $0.axis = .vertical
        return $0
    }(UIStackView())

    let buttonsStackView: UIStackView = {
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

@objc extension PopupViewController {
    func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(cardView)
        cardView.addSubview(rootStackView)
        rootStackView.addArrangedSubview(titleStackView)
        rootStackView.addArrangedSubview(bodyStackView)
        rootStackView.addArrangedSubview(buttonsStackView)
        titleStackView.addArrangedSubview(titleLabel)
        buttonsStackView.addArrangedSubview(saveButton)
        saveButton.addTarget(self, action: #selector(save), for: .primaryActionTriggered)
    }

    func setupConstraints() {
        let padding = 20.0

        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            rootStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            rootStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            rootStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            rootStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding)
        ])
    }

    func cancel() {
        dismiss(animated: true)
    }

    func save() {}
}
