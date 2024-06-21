import UIKit

final class RecentCell: UITableViewCell {
    static let identifier = "RecentCell"

    private let avatarImageView: UIImageView = {
        $0.image = .avatar
//        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private let usernameLabel: UILabel = {
        return $0
    }(UILabel())

    private let lastMessageLabel: UILabel = {
        $0.font = RubikFont.bold.size16
        return $0
    }(UILabel())

    private let dateLabel: UILabel = {
        return $0
    }(UILabel())

    private let unreadCounterLabel: UILabel = {
        $0.textAlignment = .center
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        return $0
    }(UILabel())

    public func configure(with recent: Recent) {
        usernameLabel.text = recent.name
        lastMessageLabel.text = "\(recent.playerCount) : \(recent.currentCount) Round: \(recent.round)"
        dateLabel.text = recent.date.timeElapsed
        unreadCounterLabel.text = "1"
        unreadCounterLabel.isHidden = recent.hand == 0
        FileStorage.downloadImage(id: recent.id, link: recent.avatar) { image in
            if let image {
                self.avatarImageView.image = image.circleMasked
            } else {
                self.avatarImageView.image = .avatar
            }
        }
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

extension RecentCell {
    private func setupViews() {
        [avatarImageView, usernameLabel, lastMessageLabel, dateLabel, unreadCounterLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        dateLabel.setContentHuggingPriority(.init(251), for: .horizontal)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -16),
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            
            lastMessageLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            lastMessageLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            
            unreadCounterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            unreadCounterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            unreadCounterLabel.widthAnchor.constraint(equalToConstant: 30),
            unreadCounterLabel.heightAnchor.constraint(equalTo: unreadCounterLabel.widthAnchor),
            unreadCounterLabel.leadingAnchor.constraint(equalTo: lastMessageLabel.trailingAnchor, constant: 16)
        ])
    }
}

extension Date {
    var timeElapsed: String {
        let seconds = Date().timeIntervalSince(self)
        if seconds < 60 {
            return "Just now"
        } else if seconds < 3600 {
            let minutes = Int(seconds / 60)
            let minText = minutes == 1 ? "min" : "mins"
            return "\(minutes) \(minText)"
        } else if seconds < 24 * 3600 {
            let hours = Int(seconds / 3600)
            let hoursText = hours == 1 ? "hour" : "hours"
            return "\(hours) \(hoursText)"
        } else {
            return longDate
        }
    }

    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }

    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
