//
//  RoundViewController.swift
//  EPICRPS
//
//  Created by Xcode on 10.06.2024.
//

import UIKit
import AVFoundation

class RoundViewController: UIViewController {
    var player: AVAudioPlayer?
    private lazy var useCase = RoundUseCase(service: LocalService.shared)
    private lazy var store = RoundStore(useCase: useCase)
    var bag = Bag()
    
    private let timerManager = TimerManager.shared
    
    private let customView = RoundView()
 
    // MARK: - Life Cycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        setupObservers()
        let customBackButton = UIBarButtonItem(image: UIImage(named: "Arrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = customBackButton
        playSound()
    }
    
    private func startTimer() {
        timerManager.createTimer(totalTime: 30) { [weak self] in
            guard let manager = self?.timerManager else { return }
            if manager.isTimeUp {
                manager.stopTimer()
                self?.store.sendAction(.lose)
            }
            let persentage = Float(manager.secondsLeft) / Float(manager.totalTime)
            self?.customView.updateTimer(with: persentage)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.viewControllers.forEach {
            if $0 is SplashViewController {
                self.navigationController?.popToViewController($0, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customView.resetProgress()
        startTimer()
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
        customView.updateUI(with: recent)
        timerManager.stopTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if recent.currentCount == 3 || recent.playerCount == 3 {
                self?.store.sendAction(.restart)
                let controller = FightResultViewController(recent: recent)
                self?.navigationController?.pushViewController(controller, animated: true)
            } else {
                self?.customView.setBaseState()
                self?.startTimer()
            }
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "background", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension RoundViewController: RoundViewDelegate {
    func tapStonePressed() {
        store.sendAction(.round(0))
    }
    
    func tapPaperPressed() {
        store.sendAction(.round(1))
    }
    
    func tapScissorsPressed() {
        store.sendAction(.round(2))
    }
}

@available(iOS 17.0, *)
#Preview {
    RoundViewController()
}
