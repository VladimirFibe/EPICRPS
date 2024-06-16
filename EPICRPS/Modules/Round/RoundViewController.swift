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
    
    private let roundDuration = LocalService.shared.totalTime
    
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
        let customBackButton = UIBarButtonItem(
            image: UIImage(named: "Arrow"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        let pauseButton = UIBarButtonItem(
            image: UIImage(named: "Pause"),
            style: .plain,
            target: self,
            action: #selector(pauseButtonTapped)
        )
        self.navigationItem.leftBarButtonItem = customBackButton
        self.navigationItem.rightBarButtonItem = pauseButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customView.resetProgress()
        let progress = Float(roundDuration) / Float(roundDuration)
        customView.updateTimer(with: progress, time: roundDuration)
        startTimer(roundDuration)
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
            guard let self = self else { return }
            if recent.currentCount == 3 || recent.playerCount == 3 {
                self.store.sendAction(.restart)
                let controller = FightResultViewController(recent: recent)
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                self.customView.setNewRound(with: roundDuration)
                self.startTimer(self.roundDuration)
            }
        }
    }
    
    @objc private func pauseButtonTapped() {
        timerManager.isPaused ?
        startTimer(timerManager.secondsLeft) :
        timerManager.stopTimer()
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.viewControllers.forEach {
            if $0 is SplashViewController {
                self.navigationController?.popToViewController($0, animated: true)
            }
        }
    }
    
    private func startTimer(_ time: Int) {
        timerManager.createTimer(totalTime: time) { [weak self] in
            guard
                let manager = self?.timerManager,
                let roundDuration = self?.roundDuration
            else { return }
            if manager.isTimeUp {
                manager.stopTimer()
                self?.store.sendAction(.lose)
            }
            let progress = Float(manager.secondsLeft) / Float(roundDuration)
            self?.customView.updateTimer(with: progress, time: manager.secondsLeft)
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
