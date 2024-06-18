import UIKit

final class ResultsPersonHeader: UIView {
    public var addImage: Callback?
    public var editText: Callback?
    private let imageView = UIImageView()
    private let button = UIButton(type: .system)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 46),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func setupLabel() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.baseForegroundColor = #colorLiteral(red: 0.3593698144, green: 0.4734569788, blue: 0.6506641507, alpha: 1)
        config.background.backgroundColor = .white
        config.background.strokeColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
        config.background.strokeWidth = 1
        config.contentInsets = .init(top: 14, leading: 16, bottom: 14, trailing: 16)
        config.titleAlignment = .leading
        config.title = "Player 1"
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = RubikFont.bold.size16
            return outgoing
        }
        button.configuration = config
        button.addAction(UIAction { _ in self.editText?()}, for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 7),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
