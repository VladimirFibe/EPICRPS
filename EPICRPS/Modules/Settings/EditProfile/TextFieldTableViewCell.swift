import UIKit

class TextFieldTableViewCell: UITableViewCell {
    private let textField: UITextField = {
        $0.clearButtonMode = .whileEditing
        $0.returnKeyType = .done
        $0.placeholder = "Enter name"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    var text: String {
        textField.text ?? ""
    }

    public func configure(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }

    public func configure(_ text: String) {
        textField.text = text
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup
extension TextFieldTableViewCell {
    private func setupViews() {
        contentView.addSubview(textField)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            textField.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        ])
    }
}
