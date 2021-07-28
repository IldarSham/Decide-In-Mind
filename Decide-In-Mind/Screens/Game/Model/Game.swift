//
//  Game.swift
//  Decide-In-Mind
//

import Foundation

class Game {
    
    private let expressionGenerator = ExpressionGenerator()
    
    private let selectedExpressions: [Int]
    private let expressionTypes: [Int]
    
    private var currentExpression: ExpressionData?
    
    var solutions: Int = 0
    
    init(selectedExpressions: [Int]) {
        self.selectedExpressions = selectedExpressions
        self.expressionTypes = selectedExpressions.indices.filter { selectedExpressions[$0] != -1 }
    }
    
    func start(completion: (_ expression: ExpressionData) -> ()) {
        currentExpression = generateExpression()
        completion(currentExpression!)
    }
    
    func check(result: Int) -> Bool {
        guard let currentExpression = currentExpression else { return false }
        
        if result == currentExpression.result {
            solutions += 1
            return true
        }
        
        return false
    }
    
    private func generateExpression() -> ExpressionData {
        let randExpressionType = expressionTypes.randomElement()
        
        var expressionData: ExpressionData!
        
        switch randExpressionType {
            case 0:
                expressionData = expressionGenerator.generateAddition(type: selectedExpressions[0])
            case 1:
                expressionData = expressionGenerator.generateSubtraction(type: selectedExpressions[1])
            default:
                break
        }
            
        return expressionData
    }
}
