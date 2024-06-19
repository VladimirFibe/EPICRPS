import UIKit

final class RoundBackgroundView: UIView {
    private let backgroundImage = UIImageView()
    private let upHandImage = UIImageView()
    private let downHandImage = UIImageView()
    private let titleLabel = UILabel()
    private let timerProgressView = UIProgressView()
    private let timerLabel = UILabel()
    private let topImageView = UIImageView()
    private let topProgressView = UIProgressView()
    private let borderView = UIView()
    private let bottomProgressView = UIProgressView()
    private let bottomImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImage()
        setupUpHandImage()
        setupDownHandImage()
        setupTitleLabel()
        setupTimerProgressView()
        setupTimerLabel()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with recent: Recent) {
        upHandImage.image = UIImage(named: recent.upImage)
        downHandImage.image = UIImage(named: recent.downImage)
        titleLabel.text = recent.status.title
        topProgressView.setProgress(Float(recent.playerCount) / 3.0, animated: true)
        bottomProgressView.setProgress(Float(recent.currentCount) / 3.0, animated: true)
        FileStorage.downloadImage(id: recent.id, link: recent.avatar) { image in
            if let image {
                self.topImageView.image = image.circleMasked
            }
        }
        FileStorage.downloadImage(id: recent.currentId, link: recent.currentAvatar) { image in
            if let image {
                self.bottomImageView.image = image.circleMasked
            }
        }
    }
}
// MARK: - Setup Views
extension RoundBackgroundView {
    private func setupBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.image = .background
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUpHandImage() {
        addSubview(upHandImage)
        upHandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upHandImage.topAnchor.constraint(equalTo: topAnchor),
            upHandImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
        ])
    }
    
    private func setupDownHandImage() {
        addSubview(downHandImage)
        downHandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downHandImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            downHandImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = RubikFont.bold.splashTitle
        titleLabel.textColor = .winText
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
        
    private func setupTimerProgressView() {
        addSubview(timerProgressView)
        timerProgressView.layer.cornerRadius = 5
        timerProgressView.layer.masksToBounds = true
        timerProgressView.progress = 0.25
        timerProgressView.progressTintColor = .timerProgressTint
        timerProgressView.trackTintColor = .progressTrackTint
        timerProgressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        timerProgressView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTimerLabel() {
        let timerWidth = 166.0
        let offset = 30.0
        addSubview(timerLabel)
        timerLabel.text = "0:00"
        timerLabel.textColor = .white
        timerLabel.font =  RubikFont.bold.size12
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerProgressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerProgressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset - timerWidth / 2),
            timerProgressView.widthAnchor.constraint(equalToConstant: timerWidth),
            timerProgressView.heightAnchor.constraint(equalToConstant: 10),
            timerLabel.centerXAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: timerWidth / 2 + 8)
        ])
    }
    
    private func setupProgressView() {
        [topProgressView, bottomProgressView, borderView, topImageView, bottomImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let width = 180.0
        let radius = 20.0
        topProgressView.progress = 0.0
        bottomProgressView.progress = 0.0
        topProgressView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        bottomProgressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        bottomProgressView.progressTintColor = .winText
        bottomProgressView.trackTintColor = .progressTrackTint
        topProgressView.progressTintColor = .winText
        topProgressView.trackTintColor = .progressTrackTint
        borderView.backgroundColor = .white
        topImageView.backgroundColor = .white
        topImageView.layer.cornerRadius = radius
        bottomImageView.backgroundColor = .white
        bottomImageView.layer.cornerRadius = radius
        NSLayoutConstraint.activate([
            borderView.widthAnchor.constraint(equalToConstant: 18),
            borderView.heightAnchor.constraint(equalToConstant: 1),
            borderView.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            borderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            topProgressView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor),
            topProgressView.widthAnchor.constraint(equalToConstant: width),
            topProgressView.heightAnchor.constraint(equalToConstant: 10),
            topProgressView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor, constant: -width / 2),
            bottomProgressView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor),
            bottomProgressView.widthAnchor.constraint(equalToConstant: width),
            bottomProgressView.heightAnchor.constraint(equalTo: topProgressView.heightAnchor),
            bottomProgressView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor, constant: width / 2),
            topImageView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor),
            topImageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor, constant: -width),
            topImageView.widthAnchor.constraint(equalToConstant: 2 * radius),
            topImageView.heightAnchor.constraint(equalTo: topImageView.widthAnchor),
            bottomImageView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor),
            bottomImageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor, constant: width),
            bottomImageView.widthAnchor.constraint(equalToConstant: 2 * radius),
            bottomImageView.heightAnchor.constraint(equalTo: topImageView.widthAnchor),
            
        ])
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    RoundBackgroundView()
//}
