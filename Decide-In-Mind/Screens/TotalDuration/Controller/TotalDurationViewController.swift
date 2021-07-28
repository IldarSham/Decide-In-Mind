//
//  TotalDurationViewController.swift
//  Decide-In-Mind
//

import UIKit

class TotalDurationViewController: UIViewController {

    @IBOutlet weak var totalDurationPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalDurationPicker.selectRow(UserSettings.totalDuration - 5, inComponent: 0, animated: false)
    }
}

extension TotalDurationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 26
    }
}

extension TotalDurationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 5)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserSettings.totalDuration = row + 5
    }
}
