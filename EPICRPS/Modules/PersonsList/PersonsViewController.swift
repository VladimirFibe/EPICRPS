import UIKit

final class PersonsViewController: UITableViewController {
    private var bag = Bag()
    private let store = PersonStrore()
    private var persons: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Friends"
        tableView.separatorStyle = .none
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
        setupObservers()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.sendAction(.fetch)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.identifier, for: indexPath) as? PersonCell else { fatalError()}
        cell.configure(with: persons[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        FirebaseClient.shared.friend = persons[indexPath.row]
        if let person = FirebaseClient.shared.person {
            store.sendAction(.createRecent(person, persons[indexPath.row]))
        }
    }

    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .done(let persons):
                    self.persons = persons
                    self.tableView.reloadData()
                case .push:
                    self.pushFightLoad()
                }
            }
            .store(in: &bag)
    }
    
    private func pushFightLoad() {
        guard let firstPlayer = FirebaseClient.shared.person, let secondPlayer = FirebaseClient.shared.friend else { return }
        let controller = FightLoadViewController(firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        navigationController?.pushViewController(controller, animated: true)
    }
}
