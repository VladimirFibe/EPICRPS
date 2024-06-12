//
//  FightResultViewController.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 12.06.2024.
//

import UIKit

final class FightResultViewController: UIViewController {

    private let customView = FightResultView()
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.configureView()
        customView.delegate = self
    }
    


}

extension FightResultViewController: FightResultViewDelegate {
    func homeButtonPressed() {
#warning("go to SplashVC")
    }
    
    func repeatButtonPressed() {
#warning("go to RoundOneVC")
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
    FightResultViewController()
}
