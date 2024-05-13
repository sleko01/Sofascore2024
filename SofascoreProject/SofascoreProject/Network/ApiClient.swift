//
//  ApiClient.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.04.2024..
//

import Foundation
import Alamofire

class ApiClient {
    
    func getEventInfo(id: Int, completionHandler: @escaping (EventDTO) -> Void) {
        let urlString = "https://static-api.sofascore.dev/api/event/\(id)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared
            .dataTask(with: request) { data, response, error in
                if let data {
                    let tournamentResponse = try! JSONDecoder().decode(EventDTO.self, from: data)
                    completionHandler(tournamentResponse)
                }
            }
        
        task.resume()
    }
    
    func getEventInfo(id: Int) async throws -> EventDTO {
        let urlString = "https://static-api.sofascore.dev/api/event/\(id)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let tournamentResponse = try! JSONDecoder().decode(EventDTO.self, from: data)
        return tournamentResponse
    }
    
    func getEventInfo(id: Int, completion: @escaping (Result<EventDTO, Error>) -> Void) {
        let urlString = "https://static-api.sofascore.dev/api/event/\(id)"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: EventDTO.self) { response in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
