import UIKit

final class PersonCell: UITableViewCell {
    static let identifier = "PersonCell"

    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let statusLabel = UILabel()
    private let rateLabel = UILabel()
    private let scoreLabel = UILabel()

    public func configure(with person: Person) {
        usernameLabel.text = person.name
        statusLabel.text = person.bot ? "Bot" : person.status.text
        scoreLabel.text = person.score
        rateLabel.text = person.percentString
        FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
            if let image {
                self.avatarImageView.image = image.circleMasked
            } else {
                self.avatarImageView.image = .avatar
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAvatarImageView()
        setupUsernameLabel()
        setupStatusLabel()
        setupRateLabel()
        setupScoreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup Views
extension PersonCell {
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 52),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ])
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupStatusLabel() {
        contentView.addSubview(statusLabel)
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .secondaryLabel
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor)
        ])
    }
    
    private func setupRateLabel() {
        contentView.addSubview(rateLabel)
        rateLabel.font = RubikFont.bold.size16
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor)
        ])
    }
    
    private func setupScoreLabel() {
        contentView.addSubview(scoreLabel)
        scoreLabel.font = RubikFont.regular.size12
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor)
        ])
    }
}
