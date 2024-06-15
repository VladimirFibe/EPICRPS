import UIKit

final class PopupView: UIView {
    var image: UIImage? {
        imageView.image
    }
    
    private var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(imageView)
        layer.cornerRadius = 23
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.masksToBounds = true
        backgroundColor = .systemBackground
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
