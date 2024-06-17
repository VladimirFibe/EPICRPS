import UIKit

final class SettingsViewController: UIViewController {
    private var is30: Bool {
        true // LocalService.shared.totalTime == 30
    }
    private lazy var tap30 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    private lazy var tap60 = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    private let stackView = UIStackView()
    private let timeView = SettingCellVeiw()
    private let playerView = SettingCellVeiw()
    private let titleLabel = UILabel()
    private let timeLabel30 = UILabel()
    private let timeLabel60 = UILabel()
    private let friendLabel = UILabel()
    private let friendSwitch = UISwitch()
    private let musicLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(personHandle)
        )
        setupStackView()
        setupTitleLabel()
        setupTimeLabel30()
        setupTimeLabel60()
        gameFriendLabel()
        setupSwitch()
        setupMusicLabel()
    }
    
    @objc private func personHandle() {
        let controller = EditProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
//        LocalService.shared.totalTime = sender == tap30 ? 30 : 60
        timeLabel30.backgroundColor = is30 ? .systemRed : UIColor(named: "ColorLabel")
        timeLabel60.backgroundColor = is30 ? UIColor(named: "ColorLabel") : .systemRed
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(timeView)
        stackView.addArrangedSubview(playerView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupTitleLabel() {
        timeView.addSubview(titleLabel)
        titleLabel.text = "ВРЕМЯ ИГРЫ"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -80)
        ])
    }
    
    private func setupTimeLabel30() {
        timeView.addSubview(timeLabel30)
        timeLabel30.text = "30 сек."
        timeLabel30.textColor = .white
        timeLabel30.textAlignment = .center
        timeLabel30.font = .boldSystemFont(ofSize: 20)
        timeLabel30.backgroundColor = is30 ? .systemRed : UIColor(named: "ColorLabel")
        timeLabel30.layer.cornerRadius = 15
        timeLabel30.clipsToBounds = true
        timeLabel30.addGestureRecognizer(tap30)
        timeLabel30.isUserInteractionEnabled = true
        timeLabel30.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel30.heightAnchor.constraint(equalToConstant: 40),
            timeLabel30.widthAnchor.constraint(equalToConstant: 135),
            timeLabel30.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40),
            timeLabel30.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 20),
        ])
    }
    private func setupTimeLabel60() {
        timeView.addSubview(timeLabel60)
        timeLabel60.text = "60 сек."
        timeLabel60.textAlignment = .center
        timeLabel60.textColor = .white
        timeLabel60.font = .boldSystemFont(ofSize: 20)
        timeLabel60.backgroundColor = is30 ? UIColor(named: "ColorLabel") : .systemRed
        timeLabel60.layer.cornerRadius = 15
        timeLabel60.clipsToBounds = true
        timeLabel60.addGestureRecognizer(tap60)
        timeLabel60.isUserInteractionEnabled = true
        timeLabel60.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel60.heightAnchor.constraint(equalToConstant: 40),
            timeLabel60.widthAnchor.constraint(equalToConstant: 135),
            timeLabel60.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40),
            timeLabel60.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -20),
        ])
    }
    private func setupMusicLabel() {
        playerView.addSubview(musicLabel)
        musicLabel.text = "    Фоновая музыка"
        musicLabel.textAlignment = .left
        musicLabel.textColor = .white
        musicLabel.font = .boldSystemFont(ofSize: 20)
        musicLabel.backgroundColor = UIColor(named: "ColorLabel")
        musicLabel.layer.cornerRadius = 18
        musicLabel.clipsToBounds = true
        musicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicLabel.heightAnchor.constraint(equalToConstant: 60),
            musicLabel.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 20),
            musicLabel.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 20),
            musicLabel.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20)
            
        ])
    }
    private func gameFriendLabel() {
        playerView.addSubview(friendLabel)
        friendLabel.text = "    Игра с другом"
        friendLabel.textAlignment = .left
        friendLabel.textColor = .white
        friendLabel.font = .boldSystemFont(ofSize: 20)
        friendLabel.backgroundColor = UIColor(named: "ColorLabel")
        friendLabel.layer.cornerRadius = 18
        friendLabel.clipsToBounds = true
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendLabel.heightAnchor.constraint(equalToConstant: 60),
            friendLabel.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 100),
            friendLabel.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -20),
            friendLabel.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 20),
            friendLabel.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func setupSwitch() {
        playerView.addSubview(friendSwitch)
        friendSwitch.translatesAutoresizingMaskIntoConstraints = false
        friendSwitch.addTarget(self, action: #selector(switchGameMode), for: .valueChanged)
        NSLayoutConstraint.activate([
            friendSwitch.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 115),
            friendSwitch.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -45),
            friendSwitch.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func switchGameMode(_ sender: UISwitch) {
        
    }
}
