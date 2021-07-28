//
//  ExpressionGenerator.swift
//  Decide-In-Mind
//

import Foundation

struct ExpressionData {
    let syncText: String
    let result: Int
}

struct ExpressionGenerator {
    
    private let ranges = [
        (min: 10, max: 99),
        (min: 100, max: 999),
        (min: 1000, max: 9999)
    ]
    
    func generateAddition(type: Int) -> ExpressionData {
        let a = Int.random(in: ranges[type].min...ranges[type].max)
        let b = Int.random(in: ranges[type].min...ranges[type].max)
        
        return ExpressionData(syncText: "\(a) + \(b)", result: a + b)
    }
    
    func generateSubtraction(type: Int) -> ExpressionData {
        let a = Int.random(in: ranges[type].min...ranges[type].max)
        let b = Int.random(in: ranges[type].min...a)
        
        return ExpressionData(syncText: "\(a) минус \(b)", result: a - b)
    }
}
