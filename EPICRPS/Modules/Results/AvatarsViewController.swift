import UIKit

final class AvatarsViewController: PopupViewController {
    private let avatar: String
    private let doneSaving: (String) -> ()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    
    init(avatar: String, doneSaving: @escaping (String) -> Void) {
        self.avatar = avatar
        self.doneSaving = doneSaving
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupOKButton()
    }
    
    private func setupCollectionView() {
        stackView.addArrangedSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.identifier)
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        collectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    private func setupOKButton() {
        stackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(okAction), for: .primaryActionTriggered)
    }
    
    @objc private func okAction() {
        doneSaving("avatar")
        dismiss(animated: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(0.5))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .continuous
            return layoutSection
        }
        return layout
    }
}

extension AvatarsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.identifier, for: indexPath) as? AvatarCell else { fatalError() }
        return cell
    }
}

extension AvatarsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
