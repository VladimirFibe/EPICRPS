import UIKit

final class SplashViewController: UIViewController {
    
    private let customView = SplashView()
    
    override func loadView() {
        view = customView
    }
    
   //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        setupView()
    }
    
    //MARK: - Setup views
    private func setupView() {
        navigationItem.leftBarButtonItem = .init(image: .settings, style: .plain, target: self, action: #selector(navBarLeftButtonAction))
        navigationItem.rightBarButtonItem = .init(image: .rules, style: .plain, target: self, action: #selector(navBarRightButtonAction))
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
        let fistPlayer = LocalService.shared.currentPerson
        let secondPlayer = LocalService.shared.friendPerson
        let controller = FightLoadViewController(firstPlayer: fistPlayer, secondPlayer: secondPlayer)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func resultButtonPressed() {
        let controller = ResultsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
