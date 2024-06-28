import UIKit

final class EditNameViewController: PopupViewController {
    private let name: String
    private let doneSaving: (String) -> ()
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let textStackView = UIStackView()

    init(name: String, doneSaving: @escaping (String) -> Void) {
        self.name = name
        self.doneSaving = doneSaving
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextStackView()
        setupOKButton()
    }
    
    private func setupTextStackView() {
        stackView.addArrangedSubview(textStackView)
        textStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        textStackView.axis = .vertical
        textStackView.spacing = 6
        setupTitleLabel()
        setupTextField()
    }
    
    private func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.text = "Enter player name"
        titleLabel.textColor = .x7C7C7B
        titleLabel.font = RubikFont.regular.size14
    }
    
    private func setupTextField() {
        textStackView.addArrangedSubview(textField)
        textField.text = name
        textField.placeholder = "Enter player name"
        textField.font = RubikFont.bold.size16
        textField.textColor = .x3C3D3B
        textField.backgroundColor = .xFBFBFB
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.xEDEDED.cgColor
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
    }
    
    private func setupOKButton() {
        stackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(okAction), for: .primaryActionTriggered)
    }
    
    @objc private func okAction() {
        doneSaving(textField.text ?? "")
        dismiss(animated: true)
    }
}
