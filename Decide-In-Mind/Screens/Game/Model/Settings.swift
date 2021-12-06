//
//  Settings.swift
//  Decide-In-Mind
//

import Foundation

struct ExpressionSettings {
    
    let expressionType: ExpressionType
    let expressionComplexity: ExpressionComplexity
    
    init(type: Int, complexity: Int) {
        switch type {
        case 0:
            self.expressionType = Addition()
        case 1:
            self.expressionType = Subtraction()
        default:
            self.expressionType = Addition()
        }
        
        self.expressionComplexity = ExpressionComplexity(rawValue: complexity)!
    }
}

struct GameSettings {
    
    let expressionSettings: [ExpressionSettings]
    
    init(selectedExpressions: [Int]) {

        var arr: [ExpressionSettings] = []
        
        for (index, element) in selectedExpressions.enumerated() {
            guard element != -1 else { continue }
            
            let expressionSettings = ExpressionSettings(type: index, complexity: element)
            arr.append(expressionSettings)
        }
        
        expressionSettings = arr
    }
}
