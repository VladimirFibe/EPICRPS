import UIKit

final class ResultSectionHeader: UIView {
    
    private let topRateImage = UIImageView()
    private let playersLabel = UILabel()
    private let rateLabel = UILabel()
    private let whiteView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWhiteView()
        setupTopRateImage()
        setupPlayersLabel()
        setupRateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTopRateImage() {
        addSubview(topRateImage)
        topRateImage.translatesAutoresizingMaskIntoConstraints = false
        topRateImage.image = UIImage(named: "topRate")
        topRateImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            topRateImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            topRateImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
            topRateImage.heightAnchor.constraint(equalToConstant: 95.27),
            topRateImage.widthAnchor.constraint(equalToConstant: 164)
        ])
    }
    
    private func setupPlayersLabel() {
        addSubview(playersLabel)
        playersLabel.translatesAutoresizingMaskIntoConstraints = false
        playersLabel.text = "Players"
        playersLabel.textColor = #colorLiteral(red: 0.8500664234, green: 0.8709563613, blue: 0.9088227749, alpha: 1)
        playersLabel.font = .systemFont(ofSize: 18, weight: .bold)
        NSLayoutConstraint.activate([
            playersLabel.bottomAnchor.constraint(equalTo: topRateImage.bottomAnchor, constant: -10),
            playersLabel.trailingAnchor.constraint(equalTo: topRateImage.leadingAnchor, constant: -22),
        ])
    }
    
    
    private func setupRateLabel() {
        addSubview(rateLabel)
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.text = "Rate"
        rateLabel.textColor = #colorLiteral(red: 0.8500664234, green: 0.8709563613, blue: 0.9088227749, alpha: 1)
        rateLabel.font = .systemFont(ofSize: 18, weight: .bold)
        NSLayoutConstraint.activate([
            rateLabel.bottomAnchor.constraint(equalTo: topRateImage.bottomAnchor, constant: -10),
            rateLabel.leadingAnchor.constraint(equalTo: topRateImage.trailingAnchor, constant: 26),
        ])
    }
    
    private func setupWhiteView() {
        addSubview(whiteView)
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.backgroundColor = .white
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteView.layer.cornerRadius = 40
        NSLayoutConstraint.activate([
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
