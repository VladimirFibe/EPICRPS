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


class SplashViewController: UIViewController {
    
    //MARK: - UI Components
    private let middleTopHorizontalStack = UIStackView(aligment: .fill, axis: .horizontal, distribution: .fill)
    private let middleBottomHorizontalStack = UIStackView(aligment: .fill, axis: .horizontal, distribution: .fill)
    private let middleVerticalStack = UIStackView(aligment: .center, axis: .vertical, distribution: .fill)
    private let bottomStackView = UIStackView(aligment: .center, axis: .vertical, distribution: .fill)
    private let topHandImage = UIImageView(image: .topHand)
    private let bottomHandImage = UIImageView(image: .bottomHand)
    private let startButton = UIButton(image: .start)
    private let resultButton = UIButton(image: .results)
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private let epicLable: UILabel = {
        let lable = UILabel()
        lable.text = Resources.Strings.epicLable
        lable.font = .systemFont(ofSize: 30, weight: .black)
        lable.shadowColor = .epicLableShadow
        lable.shadowOffset = CGSize(width: 2, height: 2)
        lable.textColor = .epicLable
        return lable
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setupConfiguration()
    }
    
    //MARK: - Setup views
    private func setupView() {
        addNavBarButton(at: .left, with: .settings)
        addNavBarButton(at: .right, with: .rules)
        
        view.addSubview(middleVerticalStack)
        middleVerticalStack.addArrangedSubview(middleTopHorizontalStack)
        middleTopHorizontalStack.addArrangedSubview(topSpacerView)
        middleTopHorizontalStack.addArrangedSubview(topHandImage)
        middleVerticalStack.addArrangedSubview(epicLable)
        middleVerticalStack.addArrangedSubview(middleBottomHorizontalStack)
        middleBottomHorizontalStack.addArrangedSubview(bottomHandImage)
        middleBottomHorizontalStack.addArrangedSubview(bottomSpacerView)
        view.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(startButton)
        bottomStackView.addArrangedSubview(resultButton)
    }
    
    //MARK: - Setup constraints
    
    private func setupConstraint() {
        
        let screenSize = UIScreen.main.bounds.size
        
        NSLayoutConstraint.activate([
            middleVerticalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 226),
            middleVerticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            middleVerticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            middleTopHorizontalStack.widthAnchor.constraint(equalTo: middleVerticalStack.widthAnchor),
            topHandImage.widthAnchor.constraint(equalToConstant: screenSize.width / 2),
            
            middleBottomHorizontalStack.widthAnchor.constraint(equalTo: middleVerticalStack.widthAnchor),
            bottomHandImage.widthAnchor.constraint(equalToConstant: screenSize.width / 2),
            
            bottomStackView.topAnchor.constraint(equalTo: middleVerticalStack.bottomAnchor, constant: 78),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: - Configuration views
    
    private func setupConfiguration() {
        view.backgroundColor = .splashViewBackground
        middleVerticalStack.spacing = 50
        bottomStackView.spacing = 10
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        resultButton.addTarget(self, action: #selector(resultButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc func navBarLeftButtonAction() {
        print("Tap Settings")
    }
    
    @objc func navBarRightButtonAction() {
        print("Tap Rules")
    }
    
    @objc func startButtonAction() {
        print("Tap Start Button")
    }
    
    @objc func resultButtonAction() {
        print("Tap Result Button")
    }
}

//MARK: - Extension

private extension UIButton {
    
    convenience init(image: UIImage) {
        self.init()
        self.setImage(image, for: .normal)
    }
}


private extension UIImageView {
    
    convenience init(image: UIImage) {
        self.init()
        self.image = image
        self.contentMode = .scaleAspectFit
    }
}

private extension UIStackView {
    
    convenience init(aligment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
        self.init()
        self.alignment = aligment
        self.axis = axis
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Extension for NavBarButtons

private extension SplashViewController {
    
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
    
    //MARK: - Resources
    
    private enum Resources {
        enum Strings {
            static let epicLable = "EPIC RPS"
        }
    }
}
