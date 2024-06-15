import UIKit

final class SettingsViewController: UIViewController {
    private let stackView = UIStackView()
    private let timeView = SettingCellVeiw()
    private let playerView = SettingCellVeiw()
    private let titleLabel = UILabel()
    private let friendSwitch = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        setupStackView()
        setupTitleLabel()
        setupSwitch()
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
            titleLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupSwitch() {
        playerView.addSubview(friendSwitch)
        friendSwitch.translatesAutoresizingMaskIntoConstraints = false
        friendSwitch.addTarget(self, action: #selector(switchGameMode), for: .valueChanged)
        NSLayoutConstraint.activate([
            friendSwitch.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 20),
            friendSwitch.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20),
            friendSwitch.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func switchGameMode(_ sender: UISwitch) {
        if sender.isOn {
            let controller = UINavigationController(rootViewController: PersonsViewController()) 
            present(controller, animated: true)
        }
    }
}
