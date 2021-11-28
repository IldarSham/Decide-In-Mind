//
//  InputLabel.swift
//  Decide-In-Mind
//

import UIKit

class InputLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.text = ""
        self.font = UIFont.systemFont(ofSize: 71)
        self.textColor = .white
        self.textAlignment = .right
        self.numberOfLines = 0
    }
    
    func errorAction() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(translationX: -20, y: 0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(translationX: 20, y: 0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            })
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
