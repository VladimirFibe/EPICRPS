import UIKit

final class TripButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        tintColor = .systemBackground
        backgroundColor = #colorLiteral(red: 0.9395877719, green: 0.6671555638, blue: 0.5318560004, alpha: 1)
        layer.cornerRadius = 22
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        widthAnchor.constraint(equalToConstant: 100).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
