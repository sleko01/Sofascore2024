//
//  TeamRanking.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.04.2024..
//

import Foundation

struct TeamRankingResponse: Decodable {
    
    let rankings: [TeamRanking]
}

struct TeamRanking: Decodable {
    
    let id: Int
    let points: Int
    let year: String
}
