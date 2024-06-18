import UIKit

final class ResultsViewController: UIViewController {
    private let userCase = ResultsUseCase(service: FirebaseClient.shared)
    private lazy var store = ResultsStore(useCase: userCase)
    private var bag = Bag()
    private var persons: [Person] = [] { didSet { self.tableView.reloadData() }}
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Leaderboard"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
        view.backgroundColor = .resultsBackground
        setupViews()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.sendAction(.get)
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let persons):
                    var top = persons.sorted(by: { $0.percent > $1.percent})
                    self.persons = top.count > 10 ? Array(top[0...9]): top
                }
            }.store(in: &bag)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        let headerView = ResultsPersonHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        if let person = FirebaseClient.shared.person {
            headerView.configure(with: person)
        }
        headerView.editText = {[weak self] in
            guard let self else { return }
            let controller = NameViewController()
            controller.modalPresentationStyle = .overCurrentContext
            controller.modalTransitionStyle = .crossDissolve
            controller.doneSaving = {}
            self.present(controller, animated: true)
        }
        tableView.tableHeaderView = headerView
        tableView.register(ResultsCell.self, forCellReuseIdentifier: ResultsCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell else { fatalError() }
        cell.configure(with: persons[indexPath.row], and: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ResultSectionHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
}
