//
//  ApiClient.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.04.2024..
//

import Foundation
import Alamofire
import UIKit

class ApiClient {
    
    func getAllEvents(sport: SportType, date: Date, completion: @escaping ([Tournament], Error?) -> Void) {
        let urlString = .backendUrl + "/sport/\(sport.url)/events/\(DateFormatter.dateToYearMonthDay(date: date))"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [MatchDTO].self) { response in
                switch response.result {
                case .success(let matches):
                    var tournamentsDict: [Int: Tournament] = [:]
                    
                    let group = DispatchGroup()
                    
                    for match in matches {
                        group.enter()
                        
                        let homeTeam = Team(id: match.homeTeam.id, name: match.homeTeam.name, country: match.homeTeam.country, managerName: nil, venue: nil)
                        let awayTeam = Team(id: match.awayTeam.id, name: match.awayTeam.name, country: match.awayTeam.country, managerName: nil, venue: nil)
                        
                        var tournament = Tournament(id: match.tournament.id, name: match.tournament.name, slug: match.tournament.slug, sport: match.tournament.sport, country: match.tournament.country, matchList: [])
                        
                        let mappedMatch = Match(
                            id: match.id,
                            slug: match.slug,
                            tournament: tournament,
                            homeTeam: homeTeam,
                            awayTeam: awayTeam,
                            status: match.status,
                            startDate: match.startDate,
                            homeScore: match.homeScore,
                            awayScore: match.awayScore,
                            winnerCode: match.winnerCode,
                            round: match.round
                        )
                        
                        if var existingTournament = tournamentsDict[match.tournament.id] {
                            existingTournament.matchList.append(mappedMatch)
                            tournamentsDict[match.tournament.id] = existingTournament
                        } else {
                            tournament.matchList.append(mappedMatch)
                            tournamentsDict[match.tournament.id] = tournament
                        }
                        
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        let tournaments = tournamentsDict.values.sorted { $0.name < $1.name }
                        completion(tournaments, nil)
                    }
                    
                case .failure(let error):
                    completion([], error)
                }
            }
    }
    
    func getAllTeamEvents(teamId: String, onlyOne: Bool, completion: @escaping ([Tournament], Error?) -> Void) {
        let number = onlyOne ? "0" : "1"
        let urlString = .backendUrl + "/team/\(teamId)/events/next/" + number
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [MatchDTO].self) { response in
                switch response.result {
                case .success(let matches):
                    var tournamentsDict: [Int: Tournament] = [:]
                    
                    let group = DispatchGroup()
                    
                    for match in matches {
                        group.enter()
                        
                        let homeTeam = Team(id: match.homeTeam.id, name: match.homeTeam.name, country: match.homeTeam.country, managerName: nil, venue: nil)
                        let awayTeam = Team(id: match.awayTeam.id, name: match.awayTeam.name, country: match.awayTeam.country, managerName: nil, venue: nil)
                        
                        var tournament = Tournament(id: match.tournament.id, name: match.tournament.name, slug: match.tournament.slug, sport: match.tournament.sport, country: match.tournament.country, matchList: [])
                        
                        let mappedMatch = Match(
                            id: match.id,
                            slug: match.slug,
                            tournament: tournament,
                            homeTeam: homeTeam,
                            awayTeam: awayTeam,
                            status: match.status,
                            startDate: match.startDate,
                            homeScore: match.homeScore,
                            awayScore: match.awayScore,
                            winnerCode: match.winnerCode,
                            round: match.round
                        )
                        
                        if var existingTournament = tournamentsDict[match.tournament.id] {
                            existingTournament.matchList.append(mappedMatch)
                            tournamentsDict[match.tournament.id] = existingTournament
                        } else {
                            tournament.matchList.append(mappedMatch)
                            tournamentsDict[match.tournament.id] = tournament
                        }
                        
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        let tournaments = tournamentsDict.values.sorted { $0.name < $1.name }
                        completion(tournaments, nil)
                    }
                    
                case .failure(let error):
                    completion([], error)
                }
            }
    }


    
    private func getTeamLogoByTeamId(teamId: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlString = .backendUrl + "/team/\(teamId)/image"

        AF.request(urlString, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        let error = NSError(domain: "InvalidImageData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No image found"])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchTournamentLogo(tournamentId: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let urlString = .backendUrl + "/tournament/\(tournamentId)/image"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        let error = NSError(domain: "InvalidImageData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No image found"])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getAllSports(completion: @escaping (Result<[SportDTO], Error>) -> Void) {
        let urlString = .backendUrl + "/sports"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [SportDTO].self) { response in
                switch response.result {
                case .success(let sports):
                    completion(.success(sports))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchTeamLogo(teamId: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        getTeamLogoByTeamId(teamId: teamId) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getEventByEventId(eventId: String, completion: @escaping (Result<Match, Error>) -> Void) {
        let urlString = .backendUrl + "/event/\(eventId)"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: MatchDTO.self) { response in
                switch response.result {
                case .success(let match):
                    let homeTeam = Team(id: match.homeTeam.id, name: match.homeTeam.name, country: match.homeTeam.country, managerName: nil, venue: nil)
                    let awayTeam = Team(id: match.awayTeam.id, name: match.awayTeam.name, country: match.awayTeam.country, managerName: nil, venue: nil)
                    let tournament = Tournament(id: match.tournament.id, name: match.tournament.name, slug: match.tournament.slug, sport: match.tournament.sport, country: match.tournament.country, matchList: [])
                    let mappedMatch = Match(
                        id: match.id,
                        slug: match.slug,
                        tournament: tournament,
                        homeTeam: homeTeam,
                        awayTeam: awayTeam,
                        status: match.status,
                        startDate: match.startDate,
                        homeScore: match.homeScore,
                        awayScore: match.awayScore,
                        winnerCode: match.winnerCode,
                        round: match.round)
                    completion(.success(mappedMatch))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func fetchEventIncidentsByEventId(eventId: String, completion: @escaping (Result<[Incident], Error>) -> Void) {
        let urlString = .backendUrl + "/event/\(eventId)/incidents"
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [IncidentsDTO].self) { response in
                switch response.result {
                case .success(let incidents):
                    var firstPeriodIncidents: [Incident] = []
                    var secondPeriodIncidents: [Incident] = []
                    var periodIncidents: [Incident] = []
                    
                    for incident in incidents {
                        var mappedPlayer: Player?
                        if let player = incident.player {
                            mappedPlayer = Player(
                                id: player.id,
                                name: player.name,
                                slug: player.slug,
                                country: player.country,
                                position: player.position
                            )
                        }
                        let mappedIncident = Incident(
                            player: mappedPlayer,
                            scoringTeam: incident.scoringTeam,
                            homeScore: incident.homeScore,
                            awayScore: incident.awayScore,
                            goalType: incident.goalType,
                            id: incident.id,
                            time: incident.time,
                            type: incident.type,
                            teamSide: incident.teamSide,
                            color: incident.color,
                            text: incident.text,
                            subIncidents: nil
                        )
                        
                        if incident.type == "period" {
                            periodIncidents.append(mappedIncident)
                        } else if let time = incident.time, time <= 45 {
                            firstPeriodIncidents.append(mappedIncident)
                        } else {
                            secondPeriodIncidents.append(mappedIncident)
                        }
                    }
                    
                    if let firstPeriod = periodIncidents.first(where: { $0.time == 46 }) {
                        firstPeriodIncidents = firstPeriodIncidents.sorted { ($0.time ?? 0) > ($1.time ?? 0) }
                        let firstPeriodIncident = Incident(
                            player: firstPeriod.player,
                            scoringTeam: firstPeriod.scoringTeam,
                            homeScore: firstPeriod.homeScore,
                            awayScore: firstPeriod.awayScore,
                            goalType: firstPeriod.goalType,
                            id: firstPeriod.id,
                            time: firstPeriod.time,
                            type: firstPeriod.type,
                            teamSide: firstPeriod.teamSide,
                            color: firstPeriod.color,
                            text: firstPeriod.text,
                            subIncidents: firstPeriodIncidents
                        )
                        periodIncidents[periodIncidents.firstIndex(where: { $0.id == firstPeriod.id })!] = firstPeriodIncident
                    }
                    
                    if let secondPeriod = periodIncidents.first(where: { $0.time == 91 }) {
                        secondPeriodIncidents = secondPeriodIncidents.sorted { ($0.time ?? 0) > ($1.time ?? 0) }
                        let secondPeriodIncident = Incident(
                            player: secondPeriod.player,
                            scoringTeam: secondPeriod.scoringTeam,
                            homeScore: secondPeriod.homeScore,
                            awayScore: secondPeriod.awayScore,
                            goalType: secondPeriod.goalType,
                            id: secondPeriod.id,
                            time: secondPeriod.time,
                            type: secondPeriod.type,
                            teamSide: secondPeriod.teamSide,
                            color: secondPeriod.color,
                            text: secondPeriod.text,
                            subIncidents: secondPeriodIncidents
                        )
                        periodIncidents[periodIncidents.firstIndex(where: { $0.id == secondPeriod.id })!] = secondPeriodIncident
                    }
                    periodIncidents = Array(periodIncidents.reversed())
                    completion(.success(periodIncidents))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTeamInfoByTeamId(teamId: String, completion: @escaping (Result<Team, Error>) -> Void) {
        let urlString = .backendUrl + "/team/\(teamId)"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: TeamDTO.self) { response in
                switch response.result {
                case .success(let teamDTO):
                    let mappedTeam = Team(
                        id: teamDTO.id,
                        name: teamDTO.name,
                        country: teamDTO.country,
                        managerName: teamDTO.managerName,
                        venue: teamDTO.venue)
                    completion(.success(mappedTeam))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getPlayersFromTeamByTeamId(teamId: String, completion: @escaping (Result<[Player], Error>) -> Void) {
        let urlString = .backendUrl + "/team/\(teamId)/players"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [PlayerDTO].self) { response in
                switch response.result {
                case .success(let players):
                    var mappedPlayers: [Player] = []
                    for player in players {
                        let mappedPlayer = Player(
                            id: player.id,
                            name: player.name,
                            slug: player.slug,
                            country: player.country,
                            position: player.position)
                        mappedPlayers.append(mappedPlayer)
                    }
                    completion(.success(mappedPlayers))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTeamTournamentsByTeamid(teamId: String, completion: @escaping (Result<[Tournament], Error>) -> Void) {
        let urlString = .backendUrl + "/team/\(teamId)/tournaments"
        print(teamId)
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: [TournamentDTO].self) { response in
                switch response.result {
                case .success(let tournaments):
                    var mappedTournaments: [Tournament] = []
                    for tournament in tournaments {
                        let mappedTournament = Tournament(
                            id: tournament.id,
                            name: tournament.name,
                            slug: tournament.slug,
                            sport: tournament.sport,
                            country: tournament.country)
                        mappedTournaments.append(mappedTournament)
                    }
                    completion(.success(mappedTournaments))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
