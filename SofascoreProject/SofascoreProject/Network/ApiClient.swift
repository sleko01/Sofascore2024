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
                        
                        let homeTeam = Team(id: match.homeTeam.id, name: match.homeTeam.name, country: match.homeTeam.country)
                        let awayTeam = Team(id: match.awayTeam.id, name: match.awayTeam.name, country: match.awayTeam.country)
                        
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
}
