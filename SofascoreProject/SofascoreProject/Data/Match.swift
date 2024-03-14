//
//  Match.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation

public class Match {
    private let HomeTeam: Team
    private let AwayTeam: Team
    private var StartTime: Date
    // scores are declared as optionals as the match could be in the future
    private var HomeTeamScore: Int?
    private var AwayTeamScore: Int?
    
    init(HomeTeam: Team, AwayTeam: Team, StartTime: Date, HomeTeamScore: Int? = nil, AwayTeamScore: Int? = nil) {
        self.HomeTeam = HomeTeam
        self.AwayTeam = AwayTeam
        self.StartTime = StartTime
        self.HomeTeamScore = HomeTeamScore
        self.AwayTeamScore = AwayTeamScore
    }
}
