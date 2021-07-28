//
//  ViewController.swift
//  Decide-In-Mind
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func clickStartGameButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "Game")
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc!, animated: true)
    }
}

