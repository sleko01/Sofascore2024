//
//  EventDTO.swift
//  SofascoreProject
//
//  Created by Sven Leko on 11.05.2024..
//

import Foundation

struct MatchDTO: Codable {
    
    let id: Int
    let slug: String
    let tournament: TournamentDTO
    let homeTeam: TeamDTO
    let awayTeam: TeamDTO
    let status: String
    let startDate: String
    let homeScore: ScoreDTO
    let awayScore: ScoreDTO
    let winnerCode: String?
    let round: Int
}

struct TournamentDTO: Codable {
    
    let id: Int
    let name: String
    let slug: String
    let sport: SportDTO
    let country: CountryDTO
}

struct SportDTO: Codable {
    
    let id: Int
    let name: String
    let slug: String
}

struct CountryDTO: Codable {
    
    let id: Int
    let name: String
}

struct TeamDTO: Codable {
    
    let id: Int
    let name: String
    let country: CountryDTO
}

struct ScoreDTO: Codable {
    
    let total: Int?
    let period1: Int?
    let period2: Int?
    let period3: Int?
    let period4: Int?
}

