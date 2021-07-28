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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
