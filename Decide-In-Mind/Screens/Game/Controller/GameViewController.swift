//
//  GameViewController.swift
//  Decide-In-Mind
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    let countdownLabel = CountdownLabel()
    let inputLabel = InputLabel()
    let progressView = ProgressView()
    let keyboardView = KeyboardView()
        
    let game = Game(settings: GameSettings(selectedExpressions: UserSettings.selectedExpressions))
    
    let synthesizer = AVSpeechSynthesizer()
    
    let addingToProgress = 1.0 / Float(UserSettings.totalDuration * 60)

    var timerTotalDuration: Timer!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserSettings.countdown {
            setupCountdownLabel()
            countdownLabel.startCountdown(from: 5, completion: startGame)
        } else {
            startGame()
        }
    }
}

// MARK: UI
extension GameViewController {
    
    func setupCountdownLabel() {
        view.addSubview(countdownLabel)
        
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countdownLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            countdownLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupGameUI() {
        view.backgroundColor = #colorLiteral(red: 0.1235565171, green: 0.1235801354, blue: 0.1235490516, alpha: 1)

        // keyboardView constraints
        view.addSubview(keyboardView)
        
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.topAnchor.constraint(equalTo: view.centerYAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // progressView constraints
        view.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3.0),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3.0),
            progressView.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -10.0)
        ])
        
        // inputLabel constraints
        view.addSubview(inputLabel)
        
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3.0),
            inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            inputLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            inputLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor)
        ])
    }
}

// MARK: Game
extension GameViewController {
    
    func startGame() {
        setupGameUI()
        
        keyboardView.delegate = self
        synthesizer.delegate = self
        
        game.start { expression in
            self.speak(expression.syncText)
        }
    }
    
    func stopGame(forced: Bool) {
        stopSpeaking()
        stopTimers()
        
        if !forced {
            ResultsDataManager.saveResult(solutions: Int32(game.solutions), totalDuration: Int16(UserSettings.totalDuration), date: Date())
        }
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: Keyboard
extension GameViewController: KeyboardDelegate {
    
    func clickNumericButton(number: Int) {
        inputLabel.text! += String(number)
    }
    
    func clickCheckButton() {
        guard let text = inputLabel.text else { return }
        guard let result = Int(text) else { return }
        
        if game.check(result: result) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            inputLabel.text = ""
            
            game.start { expression in
                self.speak(expression.syncText)
            }
        } else {
            inputLabel.errorAction()
        }
    }
    
    func clickExitButton() {
        let ac = UIAlertController(title: "Подтверждение", message: "Вы действительно хотите завершить тренировку?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default, handler: { _ in
            self.stopGame(forced: true)
        })
        
        let cancelAction = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func clickSkipButton() {
        inputLabel.text = ""
        
        game.start { expression in
            self.speak(expression.syncText)
        }
    }
    
    func clickDeleteButton() {
        guard let text = inputLabel.text else { return }
        if text.count > 0 {
            inputLabel.text?.removeLast()
        }
    }
}

// MARK: Speech synthesizer
extension GameViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if timerTotalDuration == nil {
            timerTotalDuration = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: totalDurationTimer)
        }
    }
    
    private func speak(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        
        synthesizer.speak(utterance)
    }
    
    private func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}

// MARK: Timer
extension GameViewController {
    
    func totalDurationTimer(timer: Timer) {
        progressView.progress += addingToProgress
            
        if progressView.progress == 1.0 {
            stopGame(forced: false)
        }
    }
    
    private func stopTimers() {
        if timerTotalDuration != nil {
            timerTotalDuration.invalidate()
        }
    }
}
