import UIKit

final class ResultsPersonHeader: UIView {
    private let imageView = UIImageView()
    private let textFieldBackground = UIView()
    private let label = UILabel()
    private let tapAvatar = UITapGestureRecognizer()
    private let tapText = UITapGestureRecognizer()
    
    var text: String {
        label.text ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupTextFieldBackground()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.addGestureRecognizer(tapAvatar)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4
        imageView.layer.cornerRadius = 23
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 46),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func setupTextFieldBackground() {
        addSubview(textFieldBackground)
        textFieldBackground.addGestureRecognizer(tapText)
        textFieldBackground.backgroundColor = .white
        textFieldBackground.translatesAutoresizingMaskIntoConstraints = false
        textFieldBackground.layer.cornerRadius = 20
        textFieldBackground.layer.borderWidth = 1
        textFieldBackground.layer.borderColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            textFieldBackground.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 7),
            textFieldBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -58),
            textFieldBackground.heightAnchor.constraint(equalToConstant: 46),
            textFieldBackground.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = RubikFont.bold.size16
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: textFieldBackground.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -16)
        ])
    }
    
    public func configure(with person: Person, target: Any, avatarAction: Selector, textAction: Selector) {
        tapText.addTarget(target, action: textAction)
        tapAvatar.addTarget(target, action: avatarAction)
        label.text = person.name
        FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
            if let image {
                self.imageView.image = image
            } else {
                self.imageView.image = .avatar
            }
        }
    }
    
    public func configure(with text: String) {
        label.text = text
    }
}


