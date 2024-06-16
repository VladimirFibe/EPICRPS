import UIKit

final class PersonsViewController: UITableViewController {
    private var persons = LocalService.shared.persons
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Friends"
        tableView.separatorStyle = .none
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { _ in
            print("add player")
        }))
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
        dismiss(animated: true)
    }
}
