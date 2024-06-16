import UIKit


final class ResultsCell: UITableViewCell {
    static let identifier = "ResultsCell"
    private let colorView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let scorerLabel = UILabel()
    private let percentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupColorView()
        setupAvatarImageView()
        setupNameLabel()
        setupPercentLabel()
        setupScorerLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with person: Person, and index: Int) {
        avatarImageView.image = UIImage(named: person.avatar)
        nameLabel.text = person.name
        switch index {
        case 1:
            colorView.backgroundColor = #colorLiteral(red: 0.9900563359, green: 0.8548592925, blue: 0.2871716619, alpha: 0.44)
            nameLabel.textColor = #colorLiteral(red: 0.9947773814, green: 0.7810302377, blue: 0.06198632717, alpha: 1)
        case 2:
            colorView.backgroundColor = #colorLiteral(red: 0.9656174779, green: 0.9691664577, blue: 0.9813721776, alpha: 1)
            nameLabel.textColor = #colorLiteral(red: 0.8076738119, green: 0.8117451072, blue: 0.8342165351, alpha: 1)
        case 3:
            colorView.backgroundColor = #colorLiteral(red: 0.969327867, green: 0.9463194013, blue: 0.918114841, alpha: 1)
            nameLabel.textColor = #colorLiteral(red: 0.8539622426, green: 0.6938371062, blue: 0.6280935407, alpha: 1)
            
        default:
            colorView.backgroundColor = .clear
            nameLabel.textColor = #colorLiteral(red: 0.72959131, green: 0.7586519718, blue: 0.8079240918, alpha: 1)
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
        scorerLabel.text = "15,220"
        scorerLabel.textAlignment = .right
        scorerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scorerLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor),
            scorerLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    private func setupPercentLabel() {
        colorView.addSubview(percentLabel)
        percentLabel.font = RubikFont.bold.size18
        percentLabel.text = "91%"
        percentLabel.textAlignment = .right
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -27.5),
            percentLabel.widthAnchor.constraint(equalToConstant: 54)
        ])
    }
}

