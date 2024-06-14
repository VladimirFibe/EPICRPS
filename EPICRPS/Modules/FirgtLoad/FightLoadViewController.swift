//
//  FightLoadViewController.swift
//  EPICRPS
//
//  Created by Семен Шевчик on 11.06.2024.
//

import UIKit

class FightLoadViewController: UIViewController {
    
    // MARK: - UI Element
    
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let firstPlayerAvatarImage = UIImageView(image: "firstPlayerAvatar")
    
    private let victoriesFirstPlayerView = UIView(counterVictories: "10", colorCounterVictories: .orange, typeCounter: "Victories/")
    
    private let loseFirstPlayerView = UIView(counterVictories: "3", colorCounterVictories: .red, typeCounter: "Lose")
    
    
    private lazy var vsLabel: UILabel = {
        let element = UILabel()
        element.text = "VS"
        element.textColor = .orange
        element.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
   
    private let secondPlayerAvatarImage = UIImageView(image: "secondPlayerAvatar")
    
    private let victoriesSecondPlayerView = UIView(counterVictories: "10", colorCounterVictories: .orange, typeCounter: "Victories/")
    
    private let loseSecondPlayerView = UIView(counterVictories: "3", colorCounterVictories: .red, typeCounter: "Lose")

    private lazy var readyLabel: UILabel = {
        let element = UILabel()
        element.text = "Get ready..."
        element.textColor = .orange
        element.font = UIFont.systemFont(ofSize: 19.5, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let controller = RoundViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        
        [
            backgroundImage, firstPlayerAvatarImage, victoriesFirstPlayerView, loseFirstPlayerView, vsLabel, secondPlayerAvatarImage, victoriesSecondPlayerView, loseSecondPlayerView, readyLabel
        ].forEach(view.addSubview)
       
    }
}

// MARK: - Setup Constraints

private extension FightLoadViewController {
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            firstPlayerAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstPlayerAvatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 152),
            firstPlayerAvatarImage.widthAnchor.constraint(equalToConstant: 87),
            firstPlayerAvatarImage.heightAnchor.constraint(equalToConstant: 100.47),
            
            victoriesFirstPlayerView.topAnchor.constraint(equalTo: firstPlayerAvatarImage.bottomAnchor, constant: 10),
            victoriesFirstPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loseFirstPlayerView.topAnchor.constraint(equalTo: victoriesFirstPlayerView.bottomAnchor, constant: 25),
            loseFirstPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            vsLabel.topAnchor.constraint(equalTo: loseFirstPlayerView.bottomAnchor, constant: 50),
            vsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondPlayerAvatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondPlayerAvatarImage.topAnchor.constraint(equalTo: vsLabel.bottomAnchor, constant: 30),
            secondPlayerAvatarImage.widthAnchor.constraint(equalToConstant: 87),
            secondPlayerAvatarImage.heightAnchor.constraint(equalToConstant: 100.47),
            
            victoriesSecondPlayerView.topAnchor.constraint(equalTo: secondPlayerAvatarImage.bottomAnchor, constant: 10),
            victoriesSecondPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loseSecondPlayerView.topAnchor.constraint(equalTo: victoriesSecondPlayerView.bottomAnchor, constant: 25),
            loseSecondPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            readyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            readyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
}


// MARK: - Extension Fot Elements

extension UIImageView {
    convenience init(image: String) {
        self.init()
        self.image = UIImage(named: image)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


extension UIView {
    convenience init(counterVictories: String, colorCounterVictories: UIColor, typeCounter: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let counter = UILabel()
        counter.text = counterVictories
        counter.textColor = colorCounterVictories
        counter.font = UIFont.systemFont(ofSize: 19.5, weight: .bold)
        counter.textAlignment = .center
        counter.translatesAutoresizingMaskIntoConstraints = false
        
        let counterName = UILabel()
        counterName.text = typeCounter
        counterName.textColor = .white
        counterName.font = UIFont.systemFont(ofSize: 19.5, weight: .bold)
        counterName.textAlignment = .center
        counterName.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(counter)
        self.addSubview(counterName)
        
        NSLayoutConstraint.activate([
           
            counter.topAnchor.constraint(equalTo: self.topAnchor),
            counter.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
   
            counterName.topAnchor.constraint(equalTo: self.topAnchor),
            counterName.leadingAnchor.constraint(equalTo: counter.trailingAnchor, constant: 5),
            counterName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
