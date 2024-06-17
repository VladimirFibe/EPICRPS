import UIKit
import Photos
import PhotosUI

final class EditProfileViewController: UITableViewController {
    private var bag = Bag()
    private let store = EditProfileStore()
    private let photoCell = PhotoTableViewCell()
    private let textFieldCell = TextFieldTableViewCell()
    private let statusCell =  UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
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
            statusCell.textLabel?.text = "status"
            FileStorage.downloadImage(id: person.id, link: person.avatar) { image in
                self.photoCell.configrure(with: image?.circleMasked)
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension EditProfileViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return photoCell
            } else {
                return textFieldCell
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
                print("Аватар сохранен")
                guard let data = image.jpegData(compressionQuality: 1.0) as? NSData else { return }
                FileStorage.saveFileLocally(data, fileName: "\(id).jpg")
            } else {
                print("Аватар не сохранен")
            }
        }
    }
}
// MARK: - UITableViewDelegate
extension EditProfileViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            print("choose status")
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
                print("Выберите другое изображение")
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
