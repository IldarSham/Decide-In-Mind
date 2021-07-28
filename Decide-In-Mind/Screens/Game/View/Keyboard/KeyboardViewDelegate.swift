//
//  KeyboardViewDelegate.swift
//  Decide-In-Mind
//

import Foundation

protocol KeyboardDelegate {
    func clickNumericButton(number: Int)
    func clickCheckButton()
    func clickExitButton()
    func clickSkipButton()
    func clickDeleteButton()
}
