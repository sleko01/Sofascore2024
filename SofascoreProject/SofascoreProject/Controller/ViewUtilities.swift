//
//  ViewUtilities.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import UIKit
import SnapKit

public class ViewUtilities {
    // font and color declaration
    static let robotoBold: UIFont = UIFont(name: "Roboto-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    static let robotoRegular: UIFont = UIFont(name: "Roboto-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    static let robotoCondensed: UIFont = UIFont(name: "Roboto-Condensed", size: 12) ?? UIFont.systemFont(ofSize: 12)
    static let black: UIColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    static let grey: UIColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
    static let red: UIColor = UIColor(red: 233/256, green: 48/256, blue: 48/256, alpha: 1)
    
    static func createDivider(in superview: UIView) -> UIView {
        let divider = UIView()
        divider.backgroundColor = grey
        superview.addSubview(divider)
        divider.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(1)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(64)
        }
        return divider
    }
    
    // functions for creating views and subviews
    
    static func createTeamView(teamName: String, imageName: String, winLossStatus: Bool, in superview: UIView, offset: CGFloat) -> TeamView {
        let teamView = TeamView(teamWinLossStatus: winLossStatus)
        teamView.teamLogo.image = UIImage(named: imageName)
        teamView.teamName.text = teamName
        teamView.teamWinLossStatus = winLossStatus
        
        superview.addSubview(teamView)
        
        teamView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(80)
            $0.top.equalToSuperview().offset(offset)
            $0.width.equalTo(216)
            $0.height.equalTo(16)
        }
        
        return teamView
    }
    
    static func createScoreView(team1Score: Int?, team2Score: Int?, inProgress: Bool, in superview: UIView) -> ScoreView {
        let scoreView = ScoreView(team1Score: team1Score, team2Score: team2Score, inProgress: inProgress)
        superview.addSubview(scoreView)
        
        scoreView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(312)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        return scoreView
    }
    
    static func createMatchTimeView(startTime: String, status: String, matchInProgress: Bool, in superview: UIView) -> MatchTimeView {
        let matchTimeView = MatchTimeView(matchInProgress: matchInProgress)
        superview.addSubview(matchTimeView)
        
        matchTimeView.matchStart.text = startTime
        matchTimeView.currentMatchTimeOrStatus.text = status
        
        matchTimeView.snp.makeConstraints {
            $0.top.leading.height.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        return matchTimeView
    }
}
