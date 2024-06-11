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
        view.backgroundColor = UIColor(named: "RulesColor")
        setupStackView()
    }
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(RulesRowView(number: 1, text: "PP"))
        stackView.addArrangedSubview(RulesRowView(number: 2, text: "PP"))
        stackView.addArrangedSubview(RulesRowView(number: 3, text: "У игрока есть 30 сек. для выбора жеста."))
        stackView.addArrangedSubview(RulesRowView(number: 4, text: "PP"))
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
        label.textColor = .black
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
        label.backgroundColor = .yellow
        label.textColor = .black
        label.text = String(number)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }
}

