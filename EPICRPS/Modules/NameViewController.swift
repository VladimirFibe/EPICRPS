import UIKit
import Photos
import PhotosUI

final class NameViewController: PopupViewController {
    var doneSaving: (() -> ())?

    let titleTextField: UITextField = {
        $0.placeholder = "Player 1"

        $0.autocapitalizationType = .words
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    @objc private func addPhoto() {
        presentPhotoPicker()
    }

    override func save() {
        titleTextField.rightViewMode = .never
//        guard titleTextField.hasValue,
//        let title = titleTextField.text
//        else { return }
//        if var trip {
//            trip.image = cardView.image
//            trip.title = title
//            TripFunctions.update(trip)
//        } else {
//            TripFunctions.create(.init(title: title, image: cardView.image))
//        }
        doneSaving?()
        dismiss(animated: true)
    }
}
// MARK: - Setup Views
extension NameViewController {
    override func setupViews() {
        super.setupViews()
//        titleStackView.addArrangedSubview(photoButton)
        bodyStackView.addArrangedSubview(titleTextField)
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOffset = .zero
        titleLabel.layer.shadowRadius = 5

//        photoButton.addTarget(self, action: #selector(addPhoto), for: .primaryActionTriggered)
//        if let trip {
//            titleTextField.text = trip.title
//            cardView.configure(with: trip.image)
//            titleLabel.text = "Edit Trip"
//        }
    }
}
// MARK: - PHPickerViewControllerDelegate
extension NameViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.cardView.configure(with: image)
            }
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
