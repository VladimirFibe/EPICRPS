import UIKit

final class RulesViewController: UIViewController {
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rules"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        view.addSubview(imageView)
        view.backgroundColor = .systemBackground
        imageView.image = .rulesView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
