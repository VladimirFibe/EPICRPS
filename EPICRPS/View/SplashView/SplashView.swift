//
//  SplashView.swift
//  EPICRPS
//
//  Created by Pavel Kostin on 12.06.2024.
//

import Foundation
import UIKit

protocol SplashViewDelegate: AnyObject {
    func startButtonPressed()
    func resultButtonPressed()
}


final class SplashView: UIView {
    
    weak var delegate: SplashViewDelegate?
    
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupConstraint()
        setupConfiguration()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startButtonPressed() {
        delegate?.startButtonPressed()
    }
    
    @objc private func resultButtonPressed() {
        delegate?.resultButtonPressed()
    }
    
    private func setupView() {
        
        addSubview(middleVerticalStack)
        middleVerticalStack.addArrangedSubview(middleTopHorizontalStack)
        middleTopHorizontalStack.addArrangedSubview(topSpacerView)
        middleTopHorizontalStack.addArrangedSubview(topHandImage)
        middleVerticalStack.addArrangedSubview(epicLable)
        middleVerticalStack.addArrangedSubview(middleBottomHorizontalStack)
        middleBottomHorizontalStack.addArrangedSubview(bottomHandImage)
        middleBottomHorizontalStack.addArrangedSubview(bottomSpacerView)
        addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(startButton)
        bottomStackView.addArrangedSubview(resultButton)
    }
    
    
    //MARK: - Setup constraints
    
    private func setupConstraint() {
        
        let screenSize = UIScreen.main.bounds.size
        
        NSLayoutConstraint.activate([
            middleVerticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 226),
            middleVerticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            middleVerticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            middleTopHorizontalStack.widthAnchor.constraint(equalTo: middleVerticalStack.widthAnchor),
            topHandImage.widthAnchor.constraint(equalToConstant: screenSize.width / 2),
            
            middleBottomHorizontalStack.widthAnchor.constraint(equalTo: middleVerticalStack.widthAnchor),
            bottomHandImage.widthAnchor.constraint(equalToConstant: screenSize.width / 2),
            
            bottomStackView.topAnchor.constraint(equalTo: middleVerticalStack.bottomAnchor, constant: 78),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    //MARK: - Configuration views
    
    private func setupConfiguration() {
        backgroundColor = .splashViewBackground
        middleVerticalStack.spacing = 50
        bottomStackView.spacing = 10
        resultButton.addTarget(self, action: #selector(resultButtonPressed), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
    }
}
