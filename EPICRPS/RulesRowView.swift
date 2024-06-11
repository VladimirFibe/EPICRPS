//
//  RulesRowView.swift
//  EPICRPS
//
//  Created by Сергей Сухарев on 11.06.2024.
//

import UIKit

class RulesRowView: UIView {
    let textLabel = UILabel()
    let numberLabel = UILabel()
    init(number: Int, text: String){
        super.init(frame: .zero)
        createNumber()
        createLabel()
        numberLabel.text = String(number)
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 8),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: 300)

        ])
         textLabel.numberOfLines = 0
         textLabel.textColor = .black
         textLabel.font = .systemFont(ofSize: 16, weight: .regular)
     }
     
     private func createNumber() {
         addSubview(numberLabel)
         numberLabel.text = "1"
         numberLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 29),
            numberLabel.heightAnchor.constraint(equalToConstant: 29),
            numberLabel.topAnchor.constraint(equalTo: topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
         numberLabel.textAlignment = .center
         numberLabel.layer.cornerRadius = 14.5
         numberLabel.layer.masksToBounds = true
         numberLabel.backgroundColor = .yellow
         numberLabel.textColor = .black
         numberLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    
     }

}
