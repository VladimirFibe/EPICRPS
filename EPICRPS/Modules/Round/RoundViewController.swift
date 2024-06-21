import UIKit
import AVFoundation

class RoundViewController: UIViewController {
    private var canFlip = false
    var player: AVAudioPlayer?
    var playerButton: AVAudioPlayer?
    private let store: RoundStore
    private var bag = Bag()
    private var buttons: [UIButton] = []
    private let backgroundView = RoundBackgroundView()
    
    init(store: RoundStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = backgroundView
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        runFightLoad()
        backgroundView.configure(with: FirebaseClient.shared.recent)
        setupButtons()
        setupObservers()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pause.circle"),
            style: .plain,
            target: self,
            action: #selector(pauseButtonTapped)
        )
        FirebaseClient.shared.createRecentObserver { recent in
            self.updateUI(with: recent)
        }
    }
    
    private func setupButtons() {
        for index in 0..<4 {
            let button = UIButton(type: .system)
            backgroundView.addSubview(button)
            buttons.append(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "button\(index)"), for: [])
            button.tag = index
            if index == 0 {
                button.addTarget(self, action: #selector(switchTapped), for: .primaryActionTriggered)
            } else {
                button.addTarget(self, action: #selector(handTapped), for: .primaryActionTriggered)
            }
        }
        NSLayoutConstraint.activate([
            buttons[0].bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            buttons[0].centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            
            buttons[2].bottomAnchor.constraint(equalTo: buttons[0].topAnchor, constant: -20),
            buttons[2].centerXAnchor.constraint(equalTo: buttons[0].centerXAnchor),
            
            buttons[1].trailingAnchor.constraint(equalTo: buttons[2].leadingAnchor, constant: -16),
            buttons[1].bottomAnchor.constraint(equalTo: buttons[2].bottomAnchor, constant: 50),
            
            buttons[3].leadingAnchor.constraint(equalTo: buttons[2].trailingAnchor, constant: 16),
            buttons[3].bottomAnchor.constraint(equalTo: buttons[2].bottomAnchor, constant: 50)
        ])
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .done:
                    self.canFlip = true
                case .push(let recent):
                    self.pushFightResult(recent: recent)
                }
            }.store(in: &bag)
    }
    
    @objc private func handTapped(_ sender: UIButton) {
        store.sendAction(.round(sender.tag))
    }
    
    @objc private func switchTapped(_ sender: UIButton) {
        store.sendAction(.random)
    }
    
    private func updateUI(with recent: Recent) {
        backgroundView.configure(with: recent)
        if canFlip && recent.completed {
            canFlip = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.store.sendAction(.flip)
            }
        }
    }
    
    @objc private func pauseButtonTapped() {}
    
}
// MARK: - Navigation
extension RoundViewController {
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func pushFightResult(recent: Recent) {
        FileStorage.downloadImage(id: recent.currentId, link: recent.currentAvatar) { image in
            let avatar = image?.circleMasked ?? .avatar
            let isVictory = recent.currentCount > recent.playerCount
            let score = "\(recent.playerCount) - \(recent.currentCount)"
            let controller = FightResultViewController(isVictory: isVictory, score: score, avatar: avatar)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func runFightLoad() {
        guard let person = FirebaseClient.shared.person, let friend = FirebaseClient.shared.friend else { return }
        let controller = FightLoadViewController(firstPlayer: person, secondPlayer: friend)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
