//
//  FightResultViewController.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 12.06.2024.
//

import UIKit

final class FightResultViewController: UIViewController {
    private let recent: Recent
    init(recent: Recent) {
        self.recent = recent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let customView = FightResultView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.configureView(with: recent)
        customView.delegate = self
    }
    
    
    
}

extension FightResultViewController: FightResultViewDelegate {
    func homeButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func repeatButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
