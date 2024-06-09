//
//  Tournament.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation
import UIKit

struct Tournament {
    
    let id: Int
    let name: String
    let slug: String
    let sport: SportDTO
    let country: CountryDTO
    var matchList: [Match] = []
}

