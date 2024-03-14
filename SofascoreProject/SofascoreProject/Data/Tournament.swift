//
//  Tournament.swift
//  SofascoreProject
//
//  Created by Sven Leko on 12.03.2024..
//

import Foundation
import UIKit

public class Tournament {
    private let Name: String
    private let Country: Country
    private let Logo: UIImage
    var MatchList: Array<Match> = []
    
    init(Name: String, Country: Country, Logo: UIImage) {
        self.Name = Name
        self.Country = Country
        self.Logo = Logo
    }
    
}
