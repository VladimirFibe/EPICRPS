//
//  RulesViewController.swift
//  EPICRPS
//
//  Created by WWDC on 12.06.2024.
//

import UIKit

final class RulesViewController: UIViewController {
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rules"
        view.backgroundColor = UIColor(named: "RulesColor")
        setupStackView()
    }
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(RulesRowView(number: 1, text: "Игра проводится между игроком и комьютером."))
        stackView.addArrangedSubview(RulesRowView(number: 2, text: """
                                                  Жесты:
                                                        Ножницы > Бумага
                                                        Бумага > Кулак
                                                        Кулак > Ножницы
                                                  """))
        stackView.addArrangedSubview(RulesRowView(number: 3, text: "У игрока есть 30 сек. для выбора жеста."))
        stackView.addArrangedSubview(RulesRowView(number: 4, text: "Игра ведётся до трёх побед одного из участников."))
        stackView.addArrangedSubview(RulesRowView(number: 5, text: "За каждую победу игрок получает 500 баллов, которые можно посмотреть на доске лидеров."))
        stackView.alignment = .fill
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
   
    
    private func createLabel(size: CGFloat = 16, weight: UIFont.Weight = .regular, text: String) -> UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(named: "TextColor")
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }
    
    private func createNumber(number: Int) -> UILabel{
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 29).isActive = true
        label.heightAnchor.constraint(equalToConstant: 29).isActive = true
        label.textAlignment = .center
        label.layer.cornerRadius = 14.5
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(named: "CircleColor")
        label.textColor = UIColor(named: "TextColor")
        label.text = String(number)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }
}
    @available (iOS 17.0, *)
    #Preview {
        UINavigationController(rootViewController: RulesViewController())
    }

