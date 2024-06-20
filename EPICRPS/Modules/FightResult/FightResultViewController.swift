import UIKit

final class FightResultViewController: UIViewController {
    private let recent: Recent
    private let fightResultView = FightResultView()
    
    init(recent: Recent) {
        self.recent = recent
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
        fightResultView.configure(with: recent)
        navigationItem.hidesBackButton = true
    }
}
