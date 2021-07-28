//
//  ResultsViewController.swift
//  Decide-In-Mind
//

import UIKit
import CoreData

class ResultsViewController: UITableViewController {
    
    let months = ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]
    
    var results = [Result]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        results = ResultsDataManager.resultsFetchRequest()
    }
}

extension ResultsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsViewCell
        
        cell.title.text = "Решено \(results[indexPath.row].solutions) заданий за \(results[indexPath.row].totalDuration) минут"
        
        let date = results[indexPath.row].date!
        let calendar = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        cell.subtitle.text = "\(calendar.day!) \(months[calendar.month!]) \(calendar.year!) года, \(calendar.hour!):\(calendar.minute!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [self] (_, _, complete) in
            ResultsDataManager.deleteResult(result: results[indexPath.row])
            
            results.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            complete(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
}
