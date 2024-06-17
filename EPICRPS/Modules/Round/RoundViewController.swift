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
    var playerButton: AVAudioPlayer?
    private lazy var useCase = RoundUseCase(service: FirebaseClient.shared)
    private lazy var store = RoundStore(useCase: useCase)
    private var bag = Bag()
    private let roundDuration = 30 // LocalService.shared.totalTime
    
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
        playSound()
        self.navigationItem.leftBarButtonItem = customBackButton
        self.navigationItem.rightBarButtonItem = pauseButton
        FirebaseClient.shared.createRecentObserver { recent in
            self.updateUI(with: recent)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customView.resetProgress()
        let progress = Float(roundDuration) / Float(roundDuration)
        customView.updateTimer(with: progress, time: roundDuration)
        startTimer(roundDuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stop()
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done:
                    break
                }
            }.store(in: &bag)
    }
    
    private func updateUI(with recent: Recent) {
        customView.updateUI(with: recent)
        timerManager.stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.customView.setNewRound(with: roundDuration)
            self.startTimer(self.roundDuration)
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
    
    func playSound(_ title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "mp3") else { return }
        playerButton = try? AVAudioPlayer(contentsOf: url)
        playerButton?.play()
    }
}

extension RoundViewController: RoundViewDelegate {
    func buttonPressed(_ hand: Int) {
        playSound("button")
        store.sendAction(.round(hand))
    }
}
