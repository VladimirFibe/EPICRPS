import UIKit
import Photos
import PhotosUI
import ProgressHUD

final class EditProfileViewController: UITableViewController {
    private var bag = Bag()
    private let store = EditProfileStore()
    private let photoCell = PhotoTableViewCell()
    private let textFieldCell = TextFieldTableViewCell()
    private let botCell = EditProfileBotCell()
    private let sexCell = EditProfileBotCell()
    private let statusCell =  UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonAction))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Edit Profile"
        store.sendAction(.fetch)
        statusCell.selectionStyle = .none
        statusCell.accessoryType = .disclosureIndicator
        textFieldCell.configure(delegate: self)
        photoCell.callback = { [weak self] in self?.presentPhotoPicker() }
        showUserInfo(FirebaseClient.shared.person)
    }

    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink {[weak self] event in
                switch event {
                case .done:
                    self?.showUserInfo(FirebaseClient.shared.person)
                }
            }.store(in: &bag)
    }

    private func showUserInfo(_ person: Person?) {
        if let person {
            textFieldCell.configure(person.name)
            botCell.configure(with: person.bot ? "Bot enabled" : "Bot disabled")
            sexCell.configure(with: person.male ? "Male" : "Famele")
            statusCell.textLabel?.text = person.status.text
            FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
                self.photoCell.configrure(with: image?.circleMasked)
            }
        }
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - UITableViewDataSource
extension EditProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 4 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: return photoCell
            case 1: return textFieldCell
            case 2: return botCell
            default: return sexCell
            }
        } else {
            return statusCell
        }
    }
}
// MARK: - Actions
extension EditProfileViewController {
    private func uploadAvatarImage(_ image: UIImage) {
        guard let id = FirebaseClient.shared.person?.id else { return }
        FileStorage.uploadImage(image, directory: "/profile/\(id).jpg") { avatarLink in
            if let avatarLink {
                self.store.sendAction(.updateAvatarLink(avatarLink))
                ProgressHUD.succeed("Аватар сохранен")
                guard let data = image.jpegData(compressionQuality: 1.0) as? NSData else { return }
                FileStorage.saveFileLocally(data, fileName: "\(id).jpg")
            } else {
                ProgressHUD.failed("Аватар не сохранен")
            }
        }
    }
}
// MARK: - UITableViewDelegate
extension EditProfileViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let controller = ProfileStatusViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else {
            if indexPath.row == 2 {
                store.handleActions(action: .updateBot)
            } else if indexPath.row == 3 {
                store.handleActions(action: .updateSex)
            }
        }
    }
}
// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textFieldCell.text.isEmpty {
            store.sendAction(.updateUsername(textFieldCell.text))
        }
        view.endEditing(true)
        return true
    }
}
// MARK: - PHPickerViewControllerDelegate
extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else {
                ProgressHUD.failed("Выберите другое изображение")
                return
            }
            DispatchQueue.main.async {
                self.photoCell.configrure(with: image)
            }
            self.uploadAvatarImage(image)
        }
    }

    func presentPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}
