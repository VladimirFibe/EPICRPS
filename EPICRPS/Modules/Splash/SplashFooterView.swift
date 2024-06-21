import UIKit

final class SplashFooterView: UIView {
    private let startButton = UIButton(type: .system)
    private let resultsButton = UIButton(type: .system)
    private let stackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with target: Any?, startAction: Selector, resultsAction: Selector) {
        startButton.addTarget(target, action: startAction, for: .primaryActionTriggered)
        resultsButton.addTarget(target, action: resultsAction, for: .primaryActionTriggered)
    }
    
    public func configure(with isEmpty: Bool) {
        stackView.axis = isEmpty ? .vertical : .horizontal
    }
    
    private func setupViews() {
        startButton.setImage(.start, for: [])
        resultsButton.setImage(.results, for: [])
        addSubview(stackView)
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(resultsButton)
        stackView.spacing = 11
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
