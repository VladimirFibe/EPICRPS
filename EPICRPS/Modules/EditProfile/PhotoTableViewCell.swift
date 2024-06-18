import UIKit

class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoTableViewCell"
    public var callback: Callback?

    private let photoImageView: UIImageView = {
        $0.image = .avatar
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private lazy var editButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Edit"
        $0.configuration = config
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addAction(UIAction { _ in self.callback?()},
                     for: .primaryActionTriggered)
        return $0
    }(UIButton(type: .system))

    private let titleLabel: UILabel = {
        $0.text = "Enter your name and add an optional profile picture"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .secondaryLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {

    }

    public func configrure(with image: UIImage?) {
        photoImageView.image = image
    }
}
// MARK: - Setup
extension PhotoTableViewCell {
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(editButton)
        contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            editButton.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
            editButton.heightAnchor.constraint(equalToConstant: 22),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            titleLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
