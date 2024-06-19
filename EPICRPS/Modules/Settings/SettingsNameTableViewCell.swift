import UIKit

class SettingsNameTableViewCell: UITableViewCell {
    static let identifier = "SettingsNameTableViewCell"

    private let photoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 29
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())

    private let titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20)
        return $0
    }(UILabel())

    private let subtitleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())

    public func configure(with person: Person) {
        titleLabel.text = person.name
        subtitleLabel.text = person.status.text
    }

    public func configure(with image: UIImage?) {
        photoImageView.image = image
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup
extension SettingsNameTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        [photoImageView, titleLabel, subtitleLabel]
            .forEach {
                contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            photoImageView.widthAnchor.constraint(equalToConstant: 58),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}

