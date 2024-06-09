//
//  InProgressOrFinishedEventView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 04.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class InProgressOrFinishedEventView: BaseView {
    
    private let homeTeamScoreLabel: UILabel = .init()
    private let awayTeamScoreLabel: UILabel = .init()
    private let hyphenLabel: UILabel = .init()
    private let matchProgressLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(homeTeamScoreLabel)
        addSubview(awayTeamScoreLabel)
        addSubview(hyphenLabel)
        addSubview(matchProgressLabel)
    }
    
    override func styleViews() {
        homeTeamScoreLabel.font = .headline1Desktop
        homeTeamScoreLabel.textAlignment = .right
        awayTeamScoreLabel.font = .headline1Desktop
        awayTeamScoreLabel.textAlignment = .left
        hyphenLabel.font = .headline1Desktop
        hyphenLabel.textAlignment = .center
        hyphenLabel.text = .minus
        matchProgressLabel.font = .micro
        matchProgressLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        homeTeamScoreLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(56)
            $0.height.equalTo(40)
        }
        
        hyphenLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(homeTeamScoreLabel.snp.trailing).offset(4)
            $0.width.equalTo(16)
            $0.height.equalTo(homeTeamScoreLabel.snp.height)
        }
        
        awayTeamScoreLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(hyphenLabel.snp.trailing).offset(4)
            $0.height.equalTo(homeTeamScoreLabel.snp.height)
        }
        
        matchProgressLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamScoreLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
}

extension InProgressOrFinishedEventView {
    
    @discardableResult
    func homeTeamScoreLabelText(_ text: String?) -> Self {
        homeTeamScoreLabel.text = text
        return self
    }
    
    @discardableResult
    func homeTeamScoreLabelTextColor(_ color: UIColor?) -> Self {
        homeTeamScoreLabel.textColor = color
        return self
    }
    
    @discardableResult
    func awayTeamScoreLabelText(_ text: String?) -> Self {
        awayTeamScoreLabel.text = text
        return self
    }
    
    @discardableResult
    func awayTeamScoreLabelTextColor(_ color: UIColor?) -> Self {
        awayTeamScoreLabel.textColor = color
        return self
    }
    
    @discardableResult
    func matchProgressLabelText(_ text: String?) -> Self {
        matchProgressLabel.text = text
        return self
    }
    
    @discardableResult
    func matchProgressLabelTextColor(_ color: UIColor?) -> Self {
        matchProgressLabel.textColor = color
        return self
    }
    
    @discardableResult
    func hyphenLabelTextColor(_ color: UIColor?) -> Self {
        hyphenLabel.textColor = color
        return self
    }
}
