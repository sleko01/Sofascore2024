//
//  DateFormatter+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 20.03.2024..
//

import Foundation

public extension DateFormatter {
    
    static func formatTimeInterval(startTime: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: startTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
