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
        addNavBarButton(at: .left, with: .settings)
        addNavBarButton(at: .right, with: .rules)
        
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
        let controller = RoundViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func resultButtonPressed() {
        print("Result button pressed")
    }
}

//MARK: - Extension for NavBarButtons

extension SplashViewController {
    
    func addNavBarButton (at position: NavBarPosition, with image: UIImage) {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonAction), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonAction), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}
