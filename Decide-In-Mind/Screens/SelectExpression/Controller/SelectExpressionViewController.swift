//
//  SelectExpressionViewController.swift
//  Decide-In-Mind
//

import UIKit

class SelectExpressionViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    var selectedRowsCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for (index, value) in UserSettings.selectedExpressions.enumerated() {
            guard value != -1 else { continue }
            
            table.cellForRow(at: IndexPath(row: value, section: index))?.accessoryType = .checkmark
            selectedRowsCount += 1
        }
    }
}

extension SelectExpressionViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if table.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            if selectedRowsCount > 1 {
                selectedRowsCount -= 1
                UserSettings.selectedExpressions[indexPath.section] = -1
                table.cellForRow(at: indexPath)?.accessoryType = .none
            }
            
            return
        }
                
        if UserSettings.selectedExpressions[indexPath.section] != -1 {
            table.cellForRow(at: IndexPath(row: UserSettings.selectedExpressions[indexPath.section], section: indexPath.section))?.accessoryType = .none
        } else {
            selectedRowsCount += 1
        }
        
        UserSettings.selectedExpressions[indexPath.section] = indexPath.row
        table.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))?.accessoryType = .checkmark
    }
}
