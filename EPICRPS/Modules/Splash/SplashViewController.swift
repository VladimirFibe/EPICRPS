import UIKit

final class SplashViewController: UITableViewController {
    private var recents: [Recent] = [] { didSet { tableView.reloadData() }}
    private let splashView = SplashView()
    private let store: SplashStore
    private var bag = Bag()
    
    init(store: SplashStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
// MARK: - Setup View
extension SplashViewController {
    private func setupViews() {
        store.sendAction(.login)
        view.backgroundColor = .xFDFEFF
        setupNavigationBar()
        splashView.configure(with: self, startAction: #selector(startAction), resultsAction: #selector(resultsAction))
        setupObservers()
        tableView.register(RecentCell.self, forCellReuseIdentifier: RecentCell.identifier)
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
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let recents):
                    self.recents = recents
                }
            }.store(in: &bag)
    }
}
// MARK: - Navigation
extension SplashViewController {
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
    
    private func runRound() {
        let useCase = RoundUseCase(service: FirebaseClient.shared)
        let store = RoundStore(useCase: useCase)
        let controller = RoundViewController(store: store)
        navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - Tableview
extension SplashViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        recents.isEmpty ? view.safeAreaLayoutGuide.layoutFrame.height : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        splashView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell
        else { fatalError()}
        let recent = recents[indexPath.row]
        cell.configure(with: recent)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        FirebaseClient.shared.recent = recents[indexPath.row]
        runRound()
    }
}
