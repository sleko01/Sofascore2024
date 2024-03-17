//
//  ViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 05.03.2024..
//

import UIKit
import SofaAcademic

class ViewController: UIViewController {
    
    let verticalStackView: UIStackView = .init()
    let laLigaView: LeagueView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // creating teams and a tournament
        let barcelona: Team = Team(name: "Barcelona", logo: UIImage(named: "barcelona"))
        let manUtd: Team = Team(name: "Manchester United", logo: UIImage(named: "man-utd"))
        let laLiga: Tournament = Tournament(name: "LaLiga", country: .Spain, logo: UIImage(named:"laliga"))
        
        // creating mock match data
        let match1: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710676800, matchStatus: .finished, homeTeamScore: 1, awayTeamScore: 2)
        let match2: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710687600, matchStatus: .inProgress, homeTeamScore: 0, awayTeamScore: 1)
        let match3: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710694800, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match4: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710700200, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        
        laLiga.matchList = [match1, match2, match3, match4]
        
        // tournament view setup
        view.addSubview(laLigaView)
        laLigaView.backgroundColor = .white
        laLigaView.logo.image = laLiga.logo
        laLigaView.countryAndNameHolder.name.text = laLiga.name
        laLigaView.countryAndNameHolder.country.text = laLiga.country.rawValue
        laLigaView.countryAndNameHolder.rightPointer.image = UIImage(named: "ic_pointer_right")
        
        laLigaView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        
        // vertical stack view setup, view holds all matches
        
        view.addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 0
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(laLigaView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        // match setup
        
        let statusList: [String] = ["FT", "47'", "-", "-"]
        let winLossStatusManUtd: [Bool] = [false, true, true, true]
        let matchStatus: [Bool] = [false, true, false, false]
        var i = 0
        for match in laLiga.matchList {
            let matchHolder: UIView = .init()
            matchHolder.snp.makeConstraints {
                $0.height.equalTo(56)
            }
            
            _ = ViewUtilities.createMatchTimeView(startTime: match.startTimeFormatted, status: statusList[i], matchInProgress: matchStatus[i], in: matchHolder)
            _ = ViewUtilities.createDivider(in: matchHolder)
            
            _ = ViewUtilities.createTeamView(teamName: match.homeTeam.name, imageName: "man-utd", winLossStatus: winLossStatusManUtd[i], in: matchHolder, offset: 10)
            _ = ViewUtilities.createTeamView(teamName: match.awayTeam.name, imageName: "barcelona", winLossStatus: true, in: matchHolder, offset: 30)
            
            _ = ViewUtilities.createScoreView(team1Score: match.homeTeamScore, team2Score: match.awayTeamScore, inProgress: matchStatus[i], in: matchHolder)
            
            verticalStackView.addArrangedSubview(matchHolder)
            i += 1
        }
    }
}

