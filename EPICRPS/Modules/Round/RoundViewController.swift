//
//  RoundViewController.swift
//  EPICRPS
//
//  Created by Xcode on 10.06.2024.
//

import UIKit

class RoundViewController: UIViewController {
    private let service = RoundService(recent: Recent(id: "id", name: "Steve", currentId: "currentId", currentName: "Me"))
    private lazy var useCase = RoundUseCase(service: service)
    private lazy var store = RoundStore(useCase: useCase)
    var bag = Bag()
    
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
    
    private lazy var verticalProgressView: UIProgressView = {
        let element = UIProgressView()       
        element.progressTintColor = .green
        element.trackTintColor = .green //будет lightGray
        element.transform = CGAffineTransform(rotationAngle: .pi / -2)
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var firstPlayerProgressView: UIProgressView = {
        let element = UIProgressView()
        element.progressTintColor = .green
        element.trackTintColor = .lightGray // Исправил цвет
        element.progress = 5
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
        element.progressTintColor = .green
        element.progressImage = .secondPlayer
        element.trackTintColor = .blue //будет lightGray
        element.transform = CGAffineTransform(rotationAngle: .pi / -2)
        element.clipsToBounds = true
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

 
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupObservers()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .systemBackground
        [backgroundImage, gameLabel, wHandsImage, vsLabel, mHandsImage, verticalProgressView, borderLabel, firstPlayerProgressView, secondPlayerProgressView, stoneFigure, paperFigure, scissorsFigure, firstLogo, secondLogo ].forEach {view.addSubview($0)}
        
        stoneFigure.addTarget(self, action: #selector(tapStone), for: .touchUpInside)
        paperFigure.addTarget(self, action: #selector(tapPaper), for: .touchUpInside)
        scissorsFigure.addTarget(self, action: #selector(tapScissors), for: .touchUpInside)
    }
    
    @objc private func tapStone() {
        store.sendAction(.round(0))
    }
    
    @objc private func tapPaper() {
        store.sendAction(.round(1))
    }
    
    @objc private func tapScissors() {
        store.sendAction(.round(2))
    }
    
    private func setupObservers() {
        
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let recent):
                    self.updateUI(with: recent)
                }
            }.store(in: &bag)
    }
    
    private func updateUI(with recent: Recent) {
        wHandsImage.image = UIImage(named: recent.playerImage)
        mHandsImage.image = UIImage(named: recent.currentImage)
        vsLabel.text = recent.text
        if recent.currentCount == 3 || recent.playerCount == 3 {
            store.sendAction(.restart)
            let controller = FightResultViewController(recent: recent)
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.wHandsImage.image = .femaleHand
                self.mHandsImage.image = .maleHand
                self.vsLabel.text = "Ваш ход"
                
            }
        }
    }
}

// MARK: - Setup Constraints
extension RoundViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wHandsImage.topAnchor.constraint(equalTo: view.topAnchor),
            wHandsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 75),
            
            vsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mHandsImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mHandsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -45),
            
            verticalProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: -75),
            verticalProgressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalProgressView.widthAnchor.constraint(equalToConstant: 200),
            verticalProgressView.heightAnchor.constraint(equalToConstant: 5),
            
            
            borderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            borderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            borderLabel.widthAnchor.constraint(equalToConstant: 20),
            borderLabel.heightAnchor.constraint(equalToConstant: 1),
            
            firstPlayerProgressView.centerXAnchor.constraint(equalTo: borderLabel.centerXAnchor),
            firstPlayerProgressView.centerYAnchor.constraint(equalTo: borderLabel.centerYAnchor, constant: -90),
            firstPlayerProgressView.widthAnchor.constraint(equalToConstant: 175),
            firstPlayerProgressView.heightAnchor.constraint(equalToConstant: 5),
            
            firstLogo.centerXAnchor.constraint(equalTo: firstPlayerProgressView.centerXAnchor),
            firstLogo.bottomAnchor.constraint(equalTo: firstPlayerProgressView.topAnchor,constant: -65),
            firstLogo.widthAnchor.constraint(equalToConstant: 40),
            firstLogo.heightAnchor.constraint(equalToConstant: 40),
            
            secondPlayerProgressView.centerXAnchor.constraint(equalTo: borderLabel.centerXAnchor),
            secondPlayerProgressView.centerYAnchor.constraint(equalTo: borderLabel.centerYAnchor, constant: 90),
            secondPlayerProgressView.widthAnchor.constraint(equalToConstant: 175),
            secondPlayerProgressView.heightAnchor.constraint(equalToConstant: 5),
            
            secondLogo.centerXAnchor.constraint(equalTo: secondPlayerProgressView.centerXAnchor),
            secondLogo.bottomAnchor.constraint(equalTo: secondPlayerProgressView.topAnchor,constant: 100),
            secondLogo.widthAnchor.constraint(equalToConstant: 40),
            secondLogo.heightAnchor.constraint(equalToConstant: 40),
            
            
            stoneFigure.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            stoneFigure.trailingAnchor.constraint(equalTo: paperFigure.leadingAnchor, constant: -15),
            stoneFigure.widthAnchor.constraint(equalToConstant: 100),
            stoneFigure.heightAnchor.constraint(equalToConstant: 100),
            
            paperFigure.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paperFigure.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            paperFigure.widthAnchor.constraint(equalToConstant: 100),
            paperFigure.heightAnchor.constraint(equalToConstant: 100),
            
            scissorsFigure.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            scissorsFigure.leadingAnchor.constraint(equalTo: paperFigure.trailingAnchor, constant: 15),
            scissorsFigure.widthAnchor.constraint(equalToConstant: 100),
            scissorsFigure.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }
}


