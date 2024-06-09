//
//  Incident.swift
//  SofascoreProject
//
//  Created by Sven Leko on 04.06.2024..
//

import Foundation

struct Incident {
    
    let player: Player?
    let scoringTeam: String?
    let homeScore: Int?
    let awayScore: Int?
    let goalType: String?
    let id: Int?
    let time: Int?
    let type: String?
    let teamSide: String?
    let color: String?
    let text: String?
    let subIncidents: [Incident]?
}
