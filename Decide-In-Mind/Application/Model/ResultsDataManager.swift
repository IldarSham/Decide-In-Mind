//
//  ResultsDataManager.swift
//  Decide-In-Mind
//

import CoreData

struct ResultsDataManager {
    
    private init() {}
    
    static func resultsFetchRequest() -> [Result] {
        let fetchRequest: NSFetchRequest<Result> = Result.fetchRequest()
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        
        var results = [Result]()
        do {
            results = try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return results
    }
    
    static func saveResult(solutions: Int32, totalDuration: Int16, date: Date) {
        let context = CoreDataManager.persistentContainer.viewContext
        
        let result = Result(context: context)
        result.solutions = solutions
        result.totalDuration = totalDuration
        result.date = date

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteResult(result: Result) {
        let context = CoreDataManager.persistentContainer.viewContext

        context.delete(result)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
