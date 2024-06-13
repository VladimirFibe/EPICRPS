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
        //textLabel.attributedText
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
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
         textLabel.numberOfLines = 0
         textLabel.textColor = UIColor(named: "TextColor")
         textLabel.font = .systemFont(ofSize: 16, weight: .regular)
     }
     
     private func createNumber() {
         addSubview(numberLabel)
         numberLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 29),
            numberLabel.heightAnchor.constraint(equalToConstant: 29),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
         ])
         numberLabel.textAlignment = .center
         numberLabel.layer.cornerRadius = 14.5
         numberLabel.layer.masksToBounds = true
         //numberLabel.layer.shadowColor = UIColor.black.cgColor
         //numberLabel.layer.shadowOffset = CGSize(width: 20, height: 20)
         numberLabel.backgroundColor = UIColor(named: "CircleColor")
         numberLabel.textColor = UIColor(named: "TextColor")
         numberLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    
     }

}
