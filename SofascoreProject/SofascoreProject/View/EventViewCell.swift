//
//  EventViewCell.swift
//  SofascoreProject
//
//  Created by Sven Leko on 25.03.2024..
//

import Foundation
import UIKit
import SofaAcademic

public class EventViewCell: UITableViewCell, BaseViewProtocol {
    
    private let matchTimeView: MatchTimeView = .init()
    private let homeTeamView: TeamView = .init()
    private let awayTeamView: TeamView = .init()
    private let scoreView: ScoreView = .init()
    private let divider: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        styleViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func matchStartTime(_ startTime: String) {
        matchTimeView.matchStartTime(startTime)
    }
    
    func statusLabel(_ currentTime: String) {
        matchTimeView.statusLabel(currentTime)
    }
    
    func currentMatchTimeColor(_ color: UIColor) {
        matchTimeView.currentMatchTimeColor(color)
    }
    
    func homeTeamLogo (_ image: UIImage) {
        homeTeamView.teamLogo(image)
    }
    
    func homeTeamName (_ name: String) {
        homeTeamView.teamName(name)
    }
    
    func homeTeamNameColor(_ color: UIColor) {
        homeTeamView.teamNameColor(color)
    }
    
    func awayTeamLogo (_ image: UIImage) {
        awayTeamView.teamLogo(image)
    }
    
    func awayTeamName (_ name: String) {
        awayTeamView.teamName(name)
    }
    
    func awayTeamNameColor(_ color: UIColor) {
        awayTeamView.teamNameColor(color)
    }
    
    func homeTeamScore(_ score: String) {
        scoreView.homeTeamScore(score)
    }

    func homeTeamScoreColor(_ color: UIColor) {
        scoreView.homeTeamScoreColor(color)
    }

    func awayTeamScore(_ score: String) {
        scoreView.awayTeamScore(score)
    }

    func awayTeamScoreColor(_ color: UIColor) {
        scoreView.awayTeamScoreColor(color)
    }
    
    public func addViews() {
        addSubview(matchTimeView)
        addSubview(divider)
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(scoreView)
    }
    
    public func styleViews() {
        divider.backgroundColor = .grey
    }
    
    public func setupConstraints() {
        divider.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(1)
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(64)
        }
        
        matchTimeView.snp.makeConstraints {
            $0.top.leading.height.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        homeTeamView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(80)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(216)
            $0.height.equalTo(16)
        }
        
        awayTeamView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(80)
            $0.top.equalToSuperview().offset(30)
            $0.width.equalTo(216)
            $0.height.equalTo(16)
        }
        
        scoreView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(312)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
}
