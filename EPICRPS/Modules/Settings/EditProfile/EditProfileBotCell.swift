import UIKit

final class EditProfileBotCell: UITableViewCell {
    static let identifier = "EditProfileBotCell"
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with text: String) {
        label.text = text
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        ])
    }
}
