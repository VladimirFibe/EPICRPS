//
//  ControllerTest.swift
//  EPICRPS
//
//  Created by Сергей Сухарев on 13.06.2024.
//

import Foundation
import UIKit

final class ControllerTest: UIViewController {
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rules"
        view.addSubview(imageView)
        imageView.image = .rules
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
@available (iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ControllerTest())
}
