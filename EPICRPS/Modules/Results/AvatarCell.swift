import UIKit

final class AvatarCell: UICollectionViewCell {
    static let identifier = "AvatarCell"
    
    private var avatarView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .green
        setupAvatarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAvatarView() {
        contentView.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.image = .avatar
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            avatarView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        
        ])
    }
}
