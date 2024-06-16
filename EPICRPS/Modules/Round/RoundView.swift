//
//  RoundView.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 15.06.2024.
//

import UIKit

protocol RoundViewDelegate: AnyObject {
    func tapStonePressed()
    func tapPaperPressed()
    func tapScissorsPressed()
}

private extension RoundView {
    struct Appearance {
        let progressTrackTintColor = UIColor(red: 35/255, green: 37/255, blue: 134/255, alpha: 1)
        let damageProgressTintColor = UIColor(red: 255/255, green: 178/255, blue: 76/255, alpha: 1)
        let timerProgressTintColor = UIColor(red: 144/255, green: 198/255, blue: 123/255, alpha: 1)
    }
}

class RoundView: UIView {
    
    weak var delegate: RoundViewDelegate?
    
    private let appearance = Appearance()
    
    // MARK: - UI Element
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleToFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var gameLabel: UILabel = {
        let element = UILabel()
        element.text = "Игра"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 20, weight: .bold)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var wHandsImage: UIImageView = {
        let element = UIImageView()
        element.image = .whand
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var vsLabel: UILabel = {
        let element = UILabel()
        element.text = "VS"
        element.textColor = .orange
        element.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mHandsImage: UIImageView = {
        let element = UIImageView()
        element.image = .mhand
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var timerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progress = 1
        element.progressTintColor = appearance.timerProgressTintColor
        element.trackTintColor = appearance.progressTrackTintColor
        element.transform = CGAffineTransform(rotationAngle: .pi / -2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var firstPlayerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progress = .zero
        element.progressTintColor = appearance.damageProgressTintColor
        element.trackTintColor = appearance.progressTrackTintColor
        element.transform = CGAffineTransform(rotationAngle: .pi / 2)
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var borderLabel: UILabel = {
        let element = UILabel()
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondPlayerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progress = .zero
        element.progressTintColor = appearance.damageProgressTintColor
        element.trackTintColor = appearance.progressTrackTintColor
        element.transform = CGAffineTransform(rotationAngle: .pi / -2)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var firstLogo: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "firstPlayer")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondLogo: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "secondPlayer")
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let stoneFigure = UIButton(nameFigure: "Stone")
    private let paperFigure = UIButton(nameFigure: "Paper")
    private let scissorsFigure = UIButton(nameFigure: "Scissors")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBaseState() {
        wHandsImage.image = .femaleHand
        mHandsImage.image = .maleHand
        vsLabel.text = "Ваш ход"
        timerProgressView.progress = 1
    }
    
    func updateUI(with recent: Recent) {
        wHandsImage.image = UIImage(named: recent.playerImage)
        mHandsImage.image = UIImage(named: recent.currentImage)
        
        let currentProgress = Float(recent.currentCount) / Float(3)
        let playerProgress = Float(recent.playerCount) / Float(3)
        secondPlayerProgressView.setProgress(currentProgress, animated: true)
        firstPlayerProgressView.setProgress(playerProgress, animated: true)
        
        vsLabel.text = recent.text
    }
    
    func resetProgress() {
        firstPlayerProgressView.progress = 0
        secondPlayerProgressView.progress = 0
    }
    
    func updateTimer(with persentage: Float) {
        timerProgressView.progress = persentage
    }
    
    // MARK: - Setup View
    private func setupView() {
        [backgroundImage, gameLabel, wHandsImage, vsLabel, mHandsImage, timerProgressView,  firstPlayerProgressView, secondPlayerProgressView, stoneFigure, paperFigure, scissorsFigure, firstLogo, secondLogo, borderLabel].forEach { self.addSubview($0) }
        
        stoneFigure.addTarget(self, action: #selector(tapStone), for: .touchUpInside)
        paperFigure.addTarget(self, action: #selector(tapPaper), for: .touchUpInside)
        scissorsFigure.addTarget(self, action: #selector(tapScissors), for: .touchUpInside)
    }
    
    @objc private func tapStone() {
        delegate?.tapStonePressed()
    }
    
    @objc private func tapPaper() {
        delegate?.tapPaperPressed()
    }
    
    @objc private func tapScissors() {
        delegate?.tapScissorsPressed()
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        paperFigure.isEnabled = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 65),
            gameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            wHandsImage.topAnchor.constraint(equalTo: self.topAnchor),
            wHandsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 75),
            
            vsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            vsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            mHandsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mHandsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -45),
            
            timerProgressView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: -75),
            timerProgressView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timerProgressView.widthAnchor.constraint(equalToConstant: 200),
            timerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            borderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            borderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            borderLabel.widthAnchor.constraint(equalToConstant: 20),
            borderLabel.heightAnchor.constraint(equalToConstant: 1),
            
            firstPlayerProgressView.centerXAnchor.constraint(equalTo: borderLabel.centerXAnchor),
            firstPlayerProgressView.centerYAnchor.constraint(equalTo: borderLabel.centerYAnchor, constant: -90),
            firstPlayerProgressView.widthAnchor.constraint(equalToConstant: 180),
            firstPlayerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            firstLogo.centerXAnchor.constraint(equalTo: firstPlayerProgressView.centerXAnchor),
            firstLogo.bottomAnchor.constraint(equalTo: firstPlayerProgressView.topAnchor,constant: -65),
            firstLogo.widthAnchor.constraint(equalToConstant: 40),
            firstLogo.heightAnchor.constraint(equalToConstant: 40),
            
            secondPlayerProgressView.centerXAnchor.constraint(equalTo: borderLabel.centerXAnchor),
            secondPlayerProgressView.centerYAnchor.constraint(equalTo: borderLabel.centerYAnchor, constant: 90),
            secondPlayerProgressView.widthAnchor.constraint(equalToConstant: 180),
            secondPlayerProgressView.heightAnchor.constraint(equalToConstant: 10),
            
            secondLogo.centerXAnchor.constraint(equalTo: secondPlayerProgressView.centerXAnchor),
            secondLogo.bottomAnchor.constraint(equalTo: secondPlayerProgressView.topAnchor,constant: 100),
            secondLogo.widthAnchor.constraint(equalToConstant: 40),
            secondLogo.heightAnchor.constraint(equalToConstant: 40),
            
            
            stoneFigure.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            stoneFigure.trailingAnchor.constraint(equalTo: paperFigure.leadingAnchor, constant: -15),
            stoneFigure.widthAnchor.constraint(equalToConstant: 100),
            stoneFigure.heightAnchor.constraint(equalToConstant: 100),
            
            paperFigure.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            paperFigure.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            paperFigure.widthAnchor.constraint(equalToConstant: 100),
            paperFigure.heightAnchor.constraint(equalToConstant: 100),
            
            scissorsFigure.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            scissorsFigure.leadingAnchor.constraint(equalTo: paperFigure.trailingAnchor, constant: 15),
            scissorsFigure.widthAnchor.constraint(equalToConstant: 100),
            scissorsFigure.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

