//
//  KeyboardView.swift
//  Decide-In-Mind
//

import UIKit

class KeyboardView: UIView {
    
    var delegate: KeyboardDelegate?
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)![0] as! UIView

        viewFromXib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewFromXib.frame = bounds
        
        addSubview(viewFromXib)
    }
    
    override func awakeFromNib() {
        commonInit()
    }
}

extension KeyboardView {
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(1.0)
        
        switch sender.tag {
            case 0...9:
                delegate?.clickNumericButton(number: sender.tag)
            case 10:
                delegate?.clickDeleteButton()
            case 11:
                delegate?.clickSkipButton()
            case 12:
                delegate?.clickExitButton()
            case 13:
                delegate?.clickCheckButton()
            default:
                break
        }
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.8)
    }
    
    @IBAction func touchDragExit(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(1.0)
    }
}
