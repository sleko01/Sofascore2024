//
//  Match.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation

public struct Match {
    
    let homeTeam: Team
    let awayTeam: Team
    var startTime: TimeInterval
    var matchStatus: MatchStatus
    // scores are declared as optionals as the match could be in the future
    var homeTeamScore: Int?
    var awayTeamScore: Int?
    var startTimeFormatted: String = ""
    
    init(homeTeam: Team, awayTeam: Team, startTime: TimeInterval, matchStatus: MatchStatus, homeTeamScore: Int?, awayTeamScore: Int?) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.startTime = startTime
        self.matchStatus = matchStatus
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.startTimeFormatted = DateFormatter.formatTimeInterval(startTime: startTime)
    }
}
