//
//  Event.swift
//  SofascoreProject
//
//  Created by Sven Leko on 15.04.2024..
//

import Foundation

struct EventDTO: Codable {
    
    let createdByNickname: String?
    let eventEditorName: String?
    let hasStandings: Bool
    let hasCupTree: Bool
    let hasIncidents: Bool
    let hasHighlights: Bool
    let hasHighlightsStream: Bool
    let game: GameDTO
    let vote: VoteDTO
    let hasStatistics: Bool
    let hasComments: Bool
    let hasInnings: Bool
    let hasLineups: Bool
    let hasOdds: Bool
    let hasTvChannels: Bool
    let hasLineupsImage: Bool
}

struct GameDTO: Codable {
    
    let sport: SportDTO
    let rows: Int?
    let tournaments: [TournamentDTO]
}

struct SportDTO: Codable {
    
    let id: Int?
    let name: String?
    let slug: String?
}

struct TournamentDTO: Codable {
    
    let tournament: TournamentDTOInfo?
    let category: CategoryDTO?
    let season: SeasonDTO?
    let hasEventPlayerStatistics: Bool?
    let hasEventPlayerHeatMap: Bool?
    let hasBoxScore: Bool?
    let displayInverseHomeAwayTeams: Bool?
    let events: [EventDetailsDTO]
}

struct CategoryDTO: Codable {
    
    let name: String?
    let priority: Int?
    let id: Int?
    let flag: String?
}

struct SeasonDTO: Codable {
    
    let name: String?
    let year: String?
    let id: Int?
}

struct EventDetailsDTO: Codable {
    
    let roundInfo: RoundInfoDTO?
    let customId: String?
    let status: StatusDTO?
    let venue: VenueDTO?
    let homeTeam: TeamDTO
    let awayTeam: TeamDTO
    let changes: ChangesDTO
    let hasHighlights: Bool?
    let hasHighlightsStream: Bool?
    let hasGlobalHighlights: Bool?
    let id: Int?
    let cardsCode: String?
    let defaultPeriodCount: Int?
    let defaultPeriodLength: Int?
    let statusDescription: String?
    let startTimestamp: Int64?
    let webUrl: String?
    let fbPostId: String?
    let hasTime: Bool?
    let resultOnly: Bool?
    let showEventNote: Bool?
    let bet365Links: BettingLinkDTO?
}

struct RoundInfoDTO: Codable {
    
    let round: Int?
}

struct StatusDTO: Codable {
    
    let code: Int?
    let type: String?
}

struct VenueDTO: Codable {
    
    let city: CityDTO?
    let stadium: StadiumDTO?
    let id: Int?
    let hasImage: Bool?
    let country: CountryDTO
}

struct CityDTO: Codable {
    
    let name: String?
}

struct StadiumDTO: Codable {
    
    let name: String?
    let capacity: Int?
}

struct CountryDTO: Codable {
    
    let name: String?
    let flag: String?
}

struct TeamDTO: Codable {
    
    let name: String?
    let slug: String?
    let shortName: String?
    let gender: String?
    let nameCode: String?
    let disabled: Bool?
    let national: Bool?
    let id: Int?
    let subTeams: [TeamDTO]?
    let teamColors: ColorsDTO?
}

struct ColorsDTO: Codable {
    
    let primary: String?
    let secondary: String?
    let text: String?
}

struct ChangesDTO: Codable {
    
    let changeTimestamp: Int?
}

struct BettingLinkDTO: Codable {
    
    let deeplink: String?
    let joinlink: String?
}

struct TournamentDTOInfo: Codable {
    
    let name: String?
    let id: Int?
    let uniqueId: Int?
    let uniqueName: String?
    let hasEventPlayerStatistics: Bool?
}

struct VoteDTO: Codable {
    
    let vote1: Int?
    let vote2: Int?
    let voteX: Int?
    let vote1Percentage: String?
    let voteXPercentage: String?
    let vote2Percentage: String?
}
