//
//  Game.swift
//  Decide-In-Mind
//

import Foundation

class Game {
    
    let settings: GameSettings
    
    let expressionGenerator = ExpressionGenerator()
    
    var currentExpression: ExpressionData?
    
    var solutions: Int = 0
        
    typealias completionHandler = (_ expression: ExpressionData) -> ()
    
    func start(completion: completionHandler) {
        let randomExpression = settings.expressionSettings.randomElement()!
        
        let expressionType = randomExpression.expressionType
        let expressionComplexity = randomExpression.expressionComplexity
        
        currentExpression = expressionGenerator.generate(type: expressionType, complexity: expressionComplexity)
        
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
    
    init(settings: GameSettings) {
        self.settings = settings
    }
}
