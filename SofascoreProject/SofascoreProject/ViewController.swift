//
//  ViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 05.03.2024..
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        // mocking the needed data
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var Laliga: Tournament = Tournament(Name: "La Liga", Country: .Spain, Logo: <#T##UIImage#>)
        
        for _ in 0...3 {
            // TODO: tu sad treba na neki nacin mockat te sve glupe podatke 
            Laliga.MatchList.append(Match(HomeTeam: <#T##Team#>, AwayTeam: <#T##Team#>, StartTime: <#T##Date#>))
        }
        // Do any additional setup after loading the view.
    }


}

