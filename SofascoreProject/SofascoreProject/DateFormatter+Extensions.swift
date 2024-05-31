//
//  DateFormatter+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 20.03.2024..
//

import Foundation

extension DateFormatter {
    
    static func formatTimeInterval(startTime: TimeInterval) -> String {
        let date: Date = .init(timeIntervalSince1970: startTime)
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatTimeInterval(startTime: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        
        if let date = inputFormatter.date(from: startTime) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func dateToShortenedDay(date: Date) -> String {
        let dateFormatter: DateFormatter = .init()
        if Calendar.current.isDate(date, inSameDayAs: Date()) {
            dateFormatter.dateFormat = "'Today'"
        } else {
            dateFormatter.dateFormat = "E"
        }
        return dateFormatter.string(from: date).uppercased()
    }
    
    static func dateToDayMonth(date: Date) -> String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date)
    }
    
    static func dateToYearMonthDay(date: Date) -> String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func dateToDateLabel(date: Date) -> String {
        let dateFormatter: DateFormatter = .init()
        if Calendar.current.isDate(date, inSameDayAs: Date()) {
            dateFormatter.dateFormat = "'Today'"
        } else {
            dateFormatter.dateFormat = "EEE, dd.MM.yyyy"
        }
        
        return dateFormatter.string(from: date)
    }
}
