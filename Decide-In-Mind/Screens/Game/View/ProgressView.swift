//
//  ProgressView.swift
//  Decide-In-Mind
//

import UIKit

class ProgressView: UIProgressView {

    init() {
        super.init(frame: .zero)
        
        self.progressViewStyle = .default
        self.progress = 0.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
