import UIKit

final class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .xFDFEFF
        setupNavigationBar()
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
}
