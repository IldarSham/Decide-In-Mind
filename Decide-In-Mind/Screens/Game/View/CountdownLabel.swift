//
//  CountdownLabel.swift
//  Decide-In-Mind
//

import UIKit

class CountdownLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.text = ""
        self.font = UIFont.systemFont(ofSize: 60)
        self.textColor = .black
        self.numberOfLines = 0
        self.textAlignment = .center
        self.alpha = 0.0
    }
    
    typealias completionHandler = () -> Void
    
    func startCountdown(from: Int, completion: @escaping completionHandler) {
        let queue = DispatchQueue(label: "AnimationQueue", qos: .userInteractive)
        let semaphore = DispatchSemaphore(value: 0)
        
        let item = DispatchWorkItem { [unowned self] in
            for i in stride(from: from, through: 1, by: -1) {
                DispatchQueue.main.async {
                    text = String(i)
                    show { hide { semaphore.signal() } }
                }
                
                semaphore.wait()
            }
        }
        
        item.notify(queue: DispatchQueue.main, execute: completion)
        
        queue.async(execute: item)
    }
    
    private func show(completion: @escaping completionHandler) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        }, completion: { _ in completion() })
    }
    
    private func hide(completion: @escaping completionHandler) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }, completion: { _ in completion() })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
