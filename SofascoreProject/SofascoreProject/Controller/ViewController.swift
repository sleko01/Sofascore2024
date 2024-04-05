//
//  ViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 05.03.2024..
//

import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {
    
    let verticalStackView: UIStackView = .init()
    let laLigaView: LeagueView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // creating teams and a tournament
        let barcelona: Team = .init(name: "Barcelona", logo: "barcelona")
        let manUtd: Team = .init(name: "Manchester United", logo: "man-utd")
        var laLiga: Tournament = .init(name: "LaLiga", country: .Spain, logo: "laliga")
        
        // creating mock match data
        let match1: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710676800, matchStatus: .finished, homeTeamScore: 1, awayTeamScore: 2)
        let match2: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710687600, matchStatus: .inProgress, homeTeamScore: 0, awayTeamScore: 1)
        let match3: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710694800, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match4: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710700200, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        
        laLiga.matchList = [match1, match2, match3, match4]
        
        // tournament view setup
        view.addSubview(laLigaView)
        laLigaView.backgroundColor = .white
        laLigaView.leagueLogoName(laLiga.logo!) // force unwrap image
        laLigaView.leagueName(laLiga.name)
        laLigaView.countryName(laLiga.country.rawValue)
        laLigaView.holderRightPointerImage(UIImage(named: "ic_pointer_right")!) // name could be put in a global static variable since it could be used in multiple ways, but where?
        
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
            
            let matchTime: MatchTimeView = createMatchTimeView(startTime: match.startTimeFormatted, status: statusList[i], matchInProgress: matchStatus[i], in: matchHolder)
            let divider: UIView = createDivider(in: matchHolder)
            
            let homeTeam: TeamView = createTeamView(teamName: match.homeTeam.name, imageName: "man-utd", winLossStatus: winLossStatusManUtd[i], in: matchHolder, offset: 10)
            let awayTeam: TeamView = createTeamView(teamName: match.awayTeam.name, imageName: "barcelona", winLossStatus: true, in: matchHolder, offset: 30)
            
            let score: ScoreView = createScoreView(team1Score: match.homeTeamScore, team2Score: match.awayTeamScore, inProgress: matchStatus[i], in: matchHolder)
            
            verticalStackView.addArrangedSubview(matchHolder)
            i += 1
        }
    }
    
    // these functions are just to seperate the logic into smaller pieces
    private func createDivider(in superview: UIView) -> UIView {
        let divider = UIView()
        divider.backgroundColor = .grey
        superview.addSubview(divider)
        divider.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(1)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(64)
        }
        return divider
    }
    
    private func createTeamView(teamName: String, imageName: String, winLossStatus: Bool, in superview: UIView, offset: CGFloat) -> TeamView {
        let teamView:TeamView = .init()
        teamView.teamLogo(UIImage(named: imageName)!)
        teamView.teamName(teamName)
        let nameColor: UIColor = winLossStatus ? .black : .grey
        teamView.teamNameColor(nameColor)
        
        superview.addSubview(teamView)
        
        teamView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(80)
            $0.top.equalToSuperview().offset(offset)
            $0.width.equalTo(216)
            $0.height.equalTo(16)
        }
        return teamView
    }
    
    private func createScoreView(team1Score: Int?, team2Score: Int?, inProgress: Bool, in superview: UIView) -> ScoreView {
        let scoreView: ScoreView = .init()
        if let homeScore = team1Score, let awayScore = team2Score {
            scoreView.homeTeamScore(String(homeScore))
            scoreView.awayTeamScore(String(awayScore))
        } else {
            scoreView.homeTeamScore("")
            scoreView.awayTeamScore("")
        }
        
        if inProgress {
            scoreView.homeTeamScoreColor(.red)
            scoreView.awayTeamScoreColor(.red)
        } else {
            if let homeScore = team1Score, let awayScore = team2Score {
                // game finished
                if homeScore > awayScore {
                    scoreView.homeTeamScoreColor(.black)
                    scoreView.awayTeamScoreColor(.grey)
                } else {
                    scoreView.homeTeamScoreColor(.grey)
                    scoreView.awayTeamScoreColor(.black)
                }
            }
        }
        
        superview.addSubview(scoreView)
        
        scoreView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(312)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        return scoreView
    }
    
    private func createMatchTimeView(startTime: String, status: String, matchInProgress: Bool, in superview: UIView) -> MatchTimeView {
        let matchTimeView: MatchTimeView = .init()
        
        matchTimeView.matchStartTime(startTime)
        matchTimeView.statusLabel(status)
        
        matchInProgress ? matchTimeView.currentMatchTimeColor(.red) : matchTimeView.currentMatchTimeColor(.grey)
        
        superview.addSubview(matchTimeView)
        
        matchTimeView.snp.makeConstraints {
            $0.top.leading.height.equalToSuperview()
            $0.width.equalTo(64)
        }
        return matchTimeView
    }
}

