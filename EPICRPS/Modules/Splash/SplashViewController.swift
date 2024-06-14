//
//  SplashViewController.swift
//  EPICRPS
//
//  Created by Xcode on 10.06.2024.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}

final class SplashViewController: UIViewController {
    
    private let customView = SplashView()
    
    override func loadView() {
        view = customView
    }
    
   //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        setupView()
    }
    
    //MARK: - Setup views
    private func setupView() {
        navigationItem.leftBarButtonItem = .init(image: .settings, style: .plain, target: self, action: #selector(navBarLeftButtonAction))
        navigationItem.rightBarButtonItem = .init(image: .rules, style: .plain, target: self, action: #selector(navBarRightButtonAction))
    }
    
    //MARK: - Actions
    
    @objc private func navBarLeftButtonAction() {
        print("Tap Settings")
    }
    
    @objc private func navBarRightButtonAction() {
        print("Tap Rules")
    }
}


extension SplashViewController: SplashViewDelegate {
    func startButtonPressed() {
        let controller = FightLoadViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func resultButtonPressed() {
        print("Result button pressed")
    }
}