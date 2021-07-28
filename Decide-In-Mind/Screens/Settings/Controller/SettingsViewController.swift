//
//  TableViewController.swift
//  Decide-In-Mind
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var countdownSwitch: UISwitch!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        totalDurationLabel.text = "\(UserSettings.totalDuration) мин."
        countdownSwitch.isOn = UserSettings.countdown
    }
    
    @IBAction func countdownValueChanged(_ sender: UISwitch) {
        UserSettings.countdown = sender.isOn
    }
    
}
