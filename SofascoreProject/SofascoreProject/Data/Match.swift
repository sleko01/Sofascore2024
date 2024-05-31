//
//  Match.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation

struct Match {
    
    let id: Int
    let slug: String
    var tournament: Tournament
    var homeTeam: Team
    var awayTeam: Team
    let status: String
    let startDate: String
    let homeScore: ScoreDTO
    let awayScore: ScoreDTO
    let winnerCode: String?
    let round: Int
}

