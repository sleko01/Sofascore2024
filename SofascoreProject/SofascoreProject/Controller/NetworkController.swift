//
//  NetworkController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.04.2024..
//

import Foundation
import UIKit

class NetworkController: UIViewController {
    
    private let apiClient: ApiClient = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        apiClient.getEventInfo(id: 11352380) {
//            print($0.game.tournaments.first!.events.first!.awayTeam.name as Any)
//        }
//
//        Task {
//            let eventInfo = try await apiClient.getEventInfo(id: 11352380)
//            print(eventInfo.game.tournaments.first!.events.first!.awayTeam.name as Any)
//        }
//
//
//        apiClient.getEventInfo(id: 11352380) { result in
//            switch result {
//            case .success(let eventInfo):
//                print(eventInfo.game.tournaments.first!.events.first!.awayTeam.name as Any)
//            case .failure(let error):
//                print("Error:", error)
//            }
//        }

    }
}
