//
//  Tournament.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation
import UIKit

public struct Tournament {
    
    let name: String
    let country: Country
    let logo: UIImage?
    var matchList: Array<Match> = []
}
