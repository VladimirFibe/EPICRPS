import UIKit

final class FightResultViewController: UIViewController {
    private let fightResultView: FightResultView
    
    init(isVictory: Bool, score: String, avatar: UIImage) {
        fightResultView = FightResultView(isVictory: isVictory, score: score, avatar: avatar)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = fightResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        fightResultView.configure(with: self, homeAction: #selector(homeAction), repeatAction: #selector(repeatAction))
    }
    
    @objc private func homeAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func repeatAction() {
        navigationController?.popViewController(animated: true)
    }
}
