//
//  ExpressionGenerator.swift
//  Decide-In-Mind
//

import Foundation

struct ExpressionGenerator {
    
    func generate(type: ExpressionType, complexity: ExpressionComplexity) -> ExpressionData {
        type.generate(range: complexity.range())
    }
}

enum ExpressionComplexity: Int {
    
    case low
    case medium
    case high
    
    func range() -> ClosedRange<Int> {
        
        switch self {
        case .low:
            return 10...99
        case .medium:
            return 100...999
        case .high:
            return 1000...9999
        }
    }
    
}
