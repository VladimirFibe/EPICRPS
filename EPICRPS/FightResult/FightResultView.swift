//
//  FightResultView.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 12.06.2024.
//

import UIKit

protocol FightResultViewDelegate: AnyObject {
    func homeButtonPressed()
    func repeatButtonPressed()
}

final class FightResultView: UIView {

    weak var delegate: FightResultViewDelegate?
    
    private let appearance = Appearance()

    private let avatarImageView = UIImageView()
    
    private lazy var avatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.avatarBackgroundColor
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
#warning("Поменять шрифт")
        label.font = .systemFont(ofSize: 21)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
#warning("Поменять шрифт")
        label.font = .systemFont(ofSize: 41)
        label.textColor = .white
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 42
        return stack
    }()
    
    private let homeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        button.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let repeatButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "repeat"), for: .normal)
        button.addTarget(self, action: #selector(repeatButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func homeButtonPressed() {
        delegate?.homeButtonPressed()
    }
    
    @objc private func repeatButtonPressed() {
        delegate?.repeatButtonPressed()
    }
    
    private func addSubviews() {
        
      addSubview(avatarBackgroundView)
        avatarBackgroundView.addSubview(avatarImageView)
        addSubview(resultLabel)
        addSubview(scoreLabel)
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(homeButton)
        buttonsStackView.addArrangedSubview(repeatButton)
    }
    
    private func makeConstraints() {
        [avatarImageView, avatarBackgroundView, resultLabel, scoreLabel, buttonsStackView, homeButton, repeatButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            avatarBackgroundView.widthAnchor.constraint(equalToConstant: 176),
            avatarBackgroundView.heightAnchor.constraint(equalToConstant: 176),
            avatarBackgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarBackgroundView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: 67),
            avatarImageView.heightAnchor.constraint(equalToConstant: 78),
            avatarImageView.centerXAnchor.constraint(equalTo: avatarBackgroundView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarBackgroundView.centerYAnchor),
            
            resultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: avatarBackgroundView.bottomAnchor, constant: 26),
            
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 6),
            
            homeButton.widthAnchor.constraint(equalToConstant: 67),
            homeButton.heightAnchor.constraint(equalToConstant: 52),
            repeatButton.widthAnchor.constraint(equalToConstant: 67),
            repeatButton.heightAnchor.constraint(equalToConstant: 52),
            buttonsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 34)
        ])
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarBackgroundView.layer.cornerRadius = avatarBackgroundView.frame.height / 2
    }
    
    func configureView() {
#warning("Переписать в соответствии с логикой")
        
        let isVictory = Bool.random()
        let isFirstPlayer = Bool.random()
        
        let innerColor = isVictory
        ? appearance.winInnerColor
        : appearance.looseInnerColor
        
        let outsideColor = isVictory
        ? appearance.winOutsideColor
        : appearance.looseOutsideColor
        
        setBackgroundView(withGradient: innerColor, outsideColor)
        
        avatarImageView.image = isFirstPlayer
        ? UIImage(named: "firstPlayerAvatar")
        : UIImage(named: "secondPlayerAvatar")
        
        resultLabel.text = isVictory
        ? "You Win"
        : "You Lose"
        
        resultLabel.textColor = isVictory 
        ? appearance.winTextColor
        : appearance.loseTextColor
        
        scoreLabel.text = "3 - 1"
    }
    
    private func setBackgroundView(withGradient innerColor: CGColor, _ outsideColor: CGColor) {
        let backgroundView = EllipticalRadialGradientView(innerColor, outsideColor)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: .zero)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}


private extension FightResultView {
    struct Appearance {
        let winTextColor = UIColor(red: 255/255, green: 178/255, blue: 76/255, alpha: 1)
        let loseTextColor = UIColor(red: 27/255, green: 18/255, blue: 46/255, alpha: 1)
        
        let avatarBackgroundColor = UIColor(red: 43/255, green: 40/255, blue: 112/255, alpha: 1)
        
        let looseInnerColor = UIColor(red: 255/255, green: 182/255, blue: 0/255, alpha: 1).cgColor
        let looseOutsideColor = UIColor(red: 238/255, green: 65/255, blue: 60/255, alpha: 1).cgColor
        
        let winInnerColor = UIColor(red: 45/255, green: 37/255, blue: 153/255, alpha: 1).cgColor
        let winOutsideColor = UIColor(red: 101/255, green: 109/255, blue: 244/255, alpha: 1).cgColor
    }
}

