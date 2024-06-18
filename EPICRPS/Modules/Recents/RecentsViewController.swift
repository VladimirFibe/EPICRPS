import UIKit

final class RecentsViewController: UITableViewController {
    private var recents: [Recent] = [] { didSet { tableView.reloadData() }}
    
    private func downloadRecents() {
        FirebaseClient.shared.downloadRecentChatsFromFireStore { recents in
            DispatchQueue.main.async {
                self.recents = recents
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadRecents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addHandle() {
        let controller = PersonsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - Setup Views
extension RecentsViewController {
    private func setupViews() {
        tableView.register(RecentCell.self, forCellReuseIdentifier: RecentCell.identifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addHandle)
        )
    }
}
// MARK: - Data Source
extension RecentsViewController {
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
}
// MARK: - Tableview Delegate
extension RecentsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        FirebaseClient.shared.recent = recents[indexPath.row]
        let controller = RoundViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
