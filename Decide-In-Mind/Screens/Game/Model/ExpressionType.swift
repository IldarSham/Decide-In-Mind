//
//  ExpressionType.swift
//  Decide-In-Mind
//

import Foundation

protocol ExpressionType {
    func generate(range: ClosedRange<Int>) -> ExpressionData
}

struct ExpressionData {
    let syncText: String
    let result: Int
}

struct Addition: ExpressionType {
    
    func generate(range: ClosedRange<Int>) -> ExpressionData {
        let a = Int.random(in: range)
        let b = Int.random(in: range)
        
        return ExpressionData(syncText: "\(a) + \(b)", result: a + b)
    }
}

struct Subtraction: ExpressionType {
    
    func generate(range: ClosedRange<Int>) -> ExpressionData {
        let a = Int.random(in: range)
        let b = Int.random(in: range.lowerBound...a)
        
        return ExpressionData(syncText: "\(a) минус \(b)", result: a - b)
    }
}
