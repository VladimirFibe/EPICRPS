import UIKit

final class SplashViewController: UIViewController {
    private var person: Person? = nil
    private let useCase = SplashUseCase(service: FirebaseClient.shared)
    private lazy var store = SplashStore(useCase: useCase)
    private let customView = SplashView()
    private var bag = Bag()
    override func loadView() {
        view = customView
    }
    
   //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.sendAction(.login)
    }
    
    //MARK: - Setup views
    private func setupView() {
        setupObservers()
        navigationItem.leftBarButtonItem = .init(image: .settings, style: .plain, target: self, action: #selector(navBarLeftButtonAction))
        navigationItem.rightBarButtonItem = .init(image: .rules, style: .plain, target: self, action: #selector(navBarRightButtonAction))
    }
    
    private func setupObservers() {
        
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let person):
                    self.person = person
                }
            }.store(in: &bag)
    }
    //MARK: - Actions
    
    @objc private func navBarLeftButtonAction() {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func navBarRightButtonAction() {
        let controller = RulesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension SplashViewController: SplashViewDelegate {
    func startButtonPressed() {
        if let person {
            if let player = FirebaseClient.shared.friend {
                store.sendAction(.start(person, player))
                let controller = FightLoadViewController(firstPlayer: person, secondPlayer: player)
                navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller = PersonsViewController()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func resultButtonPressed() {
        let controller = ResultsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
