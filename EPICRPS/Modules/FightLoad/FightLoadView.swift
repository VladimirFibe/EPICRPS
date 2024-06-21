import UIKit

final class FightLoadView: UIView {
    private var person: Person
    private var stackView = UIStackView()
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    
    init(person: Person) {
        self.person = person
        super.init(frame: .zero)
        setupStackView()
        setupImageView()
        setupTitleLable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: Setup Views
extension FightLoadView {
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupImageView() {
        stackView.addArrangedSubview(imageView)
        FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
            self.imageView.image = image?.circleMasked
        }
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func setupTitleLable() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.text = "\(person.name)\n\(person.win) Victories/\n\(person.lose) Lose"
        titleLabel.textColor = .systemBackground
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
