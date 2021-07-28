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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
