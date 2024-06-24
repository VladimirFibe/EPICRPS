import UIKit

final class EditNameViewController: PopupViewController {
    var doneSaving: (() -> ())?
    let titleLabel = UILabel()
    let textField = UITextField()
    let textStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextStackView()
        setupOKButton()
    }
    
    @objc private func okAction() {
        doneSaving?()
        dismiss(animated: true)
    }
    
    private func setupTextStackView() {
        stackView.addArrangedSubview(textStackView)
        textStackView.axis = .vertical
        setupTitleLabel()
        setupTextField()
    }
    
    private func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.text = "Enter player name"
    }
    
    private func setupTextField() {
        textStackView.addArrangedSubview(textField)
        textField.placeholder = "Enter player name"
    }
    
    private func setupOKButton() {
        stackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(okAction), for: .primaryActionTriggered)
    }
}
