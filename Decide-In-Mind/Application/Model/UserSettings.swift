//
//  UserSettings.swift
//  Decide-In-Mind
//

import Foundation

struct UserSettings {
    static var countdown: Bool {
        get {
            return UserDefaults.standard.object(forKey: "countdown") as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "countdown")
        }
    }
    
    static var totalDuration: Int {
        get {
            return UserDefaults.standard.object(forKey: "totalDuration") as? Int ?? 5
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "totalDuration")
        }
    }
    
    static var selectedExpressions: [Int] {
        get {
            return UserDefaults.standard.array(forKey: "selectedExpressions") as? [Int] ?? [1, 1]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedExpressions")
        }
    }
}
