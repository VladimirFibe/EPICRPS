//
//  TimerManager.swift
//  EPICRPS
//
//  Created by Natalia Luzianina on 15.06.2024.
//

import Foundation

class TimerManager {
    
    static let shared = TimerManager()
    private init() {}
    
    private var timer: Timer?
    private(set) var secondsLeft = 0
    private(set) var totalTime = 0
    private(set) var isPaused = true
    private var completion: (() -> Void)?
    
    
    var isTimeUp: Bool {
        secondsLeft == 0
    }
    
    func createTimer(totalTime: Int, completion: @escaping () -> Void) {
        secondsLeft = totalTime
        self.totalTime = totalTime
        
        
        stopTimer()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerFired(_:)),
            userInfo: nil,
            repeats: true
        )
        self.completion = completion
        isPaused = false
        print("createTimer secondsLeft \(secondsLeft)")
    }
    
    func stopTimer() {
        isPaused = true
        timer?.invalidate()
        print("stopTimer secondsLeft \(secondsLeft)")
    }
    
    @objc private func timerFired(_ timer: Timer) {
        secondsLeft -= 1
        completion?()
    }
}

