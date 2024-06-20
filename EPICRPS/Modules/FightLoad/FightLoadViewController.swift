import UIKit

class FightLoadViewController: UIViewController {
    private let firstPlayer: Person
    private let secondPlayer: Person
    private let backgroundImage = UIImageView()
    private let stackView = UIStackView()
    private lazy var firstPlayerView = FightLoadView(person: firstPlayer)
    private let vsLabel = UILabel()
    private lazy var secondPlayerView = FightLoadView(person: secondPlayer)
    
    init(firstPlayer: Person, secondPlayer: Person) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.hidesBackButton = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true)
        }
    }
    
    
}
// MARK: - Setup View
extension FightLoadViewController {
    private func setupView() {
        setupBackgroundImage()
        setupStackView()
        stackView.addArrangedSubview(firstPlayerView)
        setupVSLabel()
        stackView.addArrangedSubview(secondPlayerView)
        stackView.addArrangedSubview(UIView())
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.image = .background
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func setupVSLabel() {
        stackView.addArrangedSubview(vsLabel)
        vsLabel.text = "VS"
        vsLabel.textColor = .xFFB24C
        vsLabel.font = RubikFont.bold.size56
    }
}
