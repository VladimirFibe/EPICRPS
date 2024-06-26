import UIKit


final class ResultsCell: UITableViewCell {
    static let identifier = "ResultsCell"
    private let colorView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let scorerLabel = UILabel()
    private let percentLabel = UILabel()
    private let circleImage = UIImageView()
    private let indexLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupColorView()
        setupCircleImage()
        setupAvatarImageView()
        setupNameLabel()
        setupPercentLabel()
        setupScorerLabel()
        setupIndexLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with person: Person, and index: Int) {
        nameLabel.text = person.name
        percentLabel.text = person.percentString
        scorerLabel.text = person.score
        switch index {
        case 1:
            colorView.backgroundColor = .xFBD43A
            nameLabel.textColor = .xFCBD11
            circleImage.image = .circle0
        case 2:
            colorView.backgroundColor = .xF4F5F9
            nameLabel.textColor = .xC3C4CB
            circleImage.image = .circle1
        case 3:
            colorView.backgroundColor = .xF5EEE5
            nameLabel.textColor = .xD0A18F
            circleImage.image = .circle2
            
        default:
            colorView.backgroundColor = .clear
            indexLabel.textColor = .xD0D6E3
            nameLabel.textColor = .xACB4C3
            circleImage.isHidden = true
            indexLabel.text = String(index)
        }
        
        FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
            if let image {
                self.avatarImageView.image = image.circleMasked
            } else {
                self.avatarImageView.image = .avatar
            }
        }
    }
    
    private func setupColorView() {
        contentView.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            colorView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func setupAvatarImageView() {
        colorView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 36),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func setupNameLabel() {
        colorView.addSubview(nameLabel)
        nameLabel.font = RubikFont.bold.size14
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    private func setupScorerLabel() {
        colorView.addSubview(scorerLabel)
        scorerLabel.font = RubikFont.bold.size13
        scorerLabel.textAlignment = .right
        scorerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scorerLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor),
            scorerLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            scorerLabel.widthAnchor.constraint(equalToConstant: 70),
            scorerLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func setupPercentLabel() {
        colorView.addSubview(percentLabel)
        percentLabel.font = RubikFont.bold.size18
        percentLabel.textAlignment = .right
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -27.5),
            percentLabel.widthAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func setupIndexLabel() {
        colorView.addSubview(indexLabel)
        indexLabel.font = RubikFont.bold.size9
        indexLabel.textAlignment = .left
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indexLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor)
        ])
    }
    private func setupCircleImage() {
        contentView.addSubview(circleImage)
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleImage.centerXAnchor.constraint(equalTo: colorView.trailingAnchor),
            circleImage.centerYAnchor.constraint(equalTo: colorView.centerYAnchor)
        ])
    }
}

