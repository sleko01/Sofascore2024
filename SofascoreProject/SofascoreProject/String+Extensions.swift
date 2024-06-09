//
//  String+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 30.05.2024..
//

import Foundation


extension String {
    
    static let backendUrl = "https://academy-backend.sofascore.dev"
    static let minus = "-"
    static let fulltime = "Full Time"
    static let noResultsYet = "No results yet."
    static let left = "left"
    static let right = "right"
    static let home = "home"
    static let away = "away"
    static let foul = "Foul"
    static let details = "Details"
    static let matches = "Matches"
    
    static func checkEmailFormatIsValid(email: String) -> Bool {
        let emailRegex: String = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let regex = try? NSRegularExpression(pattern: emailRegex, options: .caseInsensitive)
        let range = NSRange(location: 0, length: email.utf16.count)
        
        if let match = regex?.firstMatch(in: email, options: [], range: range) {
            return match.range.location != NSNotFound
        }
        
        return false
    }
    
    static func checkPasswordFormatIsValid(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$"
        let regex = try? NSRegularExpression(pattern: passwordRegex, options: [])
        let range = NSRange(location: 0, length: password.utf16.count)
        
        if let match = regex?.firstMatch(in: password, options: [], range: range) {
            return match.range.location != NSNotFound
        }
        
        return false
    }
}
