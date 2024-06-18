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
    
    private let avatarImageView = UIImageView()
    
    private lazy var avatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .avatarBackground
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = RubikFont.bold.size21
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = RubikFont.bold.size41
        label.textColor = .white
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 42
        return stack
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "home"), for: .normal)
        button.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var repeatButton: UIButton = {
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
        [avatarImageView, avatarBackgroundView, resultLabel, scoreLabel, buttonsStackView]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            avatarBackgroundView.widthAnchor.constraint(equalToConstant: 176),
            avatarBackgroundView.heightAnchor.constraint(equalTo: avatarBackgroundView.widthAnchor),
            avatarBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarBackgroundView.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: 78),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: avatarBackgroundView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarBackgroundView.centerYAnchor),
            
            resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: avatarBackgroundView.bottomAnchor, constant: 26),
            
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 6),
            
            homeButton.widthAnchor.constraint(equalToConstant: 67),
            homeButton.heightAnchor.constraint(equalToConstant: 52),
            repeatButton.widthAnchor.constraint(equalToConstant: 67),
            repeatButton.heightAnchor.constraint(equalToConstant: 52),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 34)
        ])
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarBackgroundView.layer.cornerRadius = avatarBackgroundView.frame.height / 2
    }
    
    func configureView(with recent: Recent) {
        
        let isVictory = recent.currentCount > recent.playerCount
        
        let innerColor: UIColor = isVictory ? .winInner : .looseInner
        
        let outsideColor: UIColor = isVictory ? .winOutside : .looseOutside
        
        setBackgroundView(withGradient: innerColor.cgColor, outsideColor.cgColor)
        
        FileStorage.downloadImage(id: recent.currentId, link: recent.currentAvatar) { image in
            self.avatarImageView.image = image?.circleMasked
        }
        
        resultLabel.text = isVictory ? "You Win" : "You Lose"
        
        resultLabel.textColor = isVictory ? .winText : .loseText
        
        scoreLabel.text = "\(recent.currentCount) - \(recent.playerCount)"
    }
    
    private func setBackgroundView(withGradient innerColor: CGColor, _ outsideColor: CGColor) {
        let backgroundView = EllipticalRadialGradientView(innerColor, outsideColor)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: .zero)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

