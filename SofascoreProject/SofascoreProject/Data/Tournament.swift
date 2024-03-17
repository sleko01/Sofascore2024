//
//  Tournament.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation
import UIKit

public class Tournament {
    let name: String
    let country: Country
    let logo: UIImage?
    var matchList: Array<Match> = []
    
    init(name: String, country: Country, logo: UIImage?) {
        self.name = name
        self.country = country
        self.logo = logo
    }
    
}
