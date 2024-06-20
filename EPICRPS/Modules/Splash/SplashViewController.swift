import UIKit

final class SplashViewController: UITableViewController {
    private var recents: [String] = []
    private let splashView = SplashView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .xFDFEFF
        setupNavigationBar()
        splashView.configure(with: self, startAction: #selector(startAction), resultsAction: #selector(resultsAction))
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = .init(
            image: .settings35,
            style: .plain,
            target: self,
            action: #selector(navBarLeftButtonAction)
        )
        
        navigationItem.rightBarButtonItem = .init(
            image: .rulers35,
            style: .plain,
            target: self,
            action: #selector(navBarRightButtonAction)
        )
    }
    
    @objc private func navBarLeftButtonAction() {
        let controller = UIViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func navBarRightButtonAction() {
        let controller = UIViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func startAction() {
        let controller = UIViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func resultsAction() {
        let controller = UIViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SplashViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        recents.isEmpty ? view.safeAreaLayoutGuide.layoutFrame.height : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        splashView
    }
}
