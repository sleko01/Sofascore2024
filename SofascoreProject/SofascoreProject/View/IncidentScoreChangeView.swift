//
//  IncidentScoreChangeView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class IncidentScoreChangeView: BaseView {
    
    private let homeTeamScoreLabel: UILabel = .init()
    private let awayTeamScoreLabel: UILabel = .init()
    private let hyphenLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(homeTeamScoreLabel)
        addSubview(awayTeamScoreLabel)
        addSubview(hyphenLabel)
    }
    
    override func styleViews() {
        homeTeamScoreLabel.font = .headline1
        homeTeamScoreLabel.textColor = .onSurfaceOnSurfaceLv1
        homeTeamScoreLabel.textAlignment = .right
        awayTeamScoreLabel.font = .headline1
        awayTeamScoreLabel.textColor = .onSurfaceOnSurfaceLv1
        awayTeamScoreLabel.textAlignment = .left
        hyphenLabel.font = .headline1
        hyphenLabel.textColor = .onSurfaceOnSurfaceLv1
        hyphenLabel.textAlignment = .center
        hyphenLabel.text = .minus
    }
    
    override func setupConstraints() {
        homeTeamScoreLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(32)
            $0.height.equalTo(28)
        }
        
        hyphenLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(homeTeamScoreLabel.snp.trailing).offset(4)
            $0.width.equalTo(12)
            $0.height.equalTo(homeTeamScoreLabel.snp.height)
        }
        
        awayTeamScoreLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(hyphenLabel.snp.trailing).offset(4)
            $0.height.equalTo(homeTeamScoreLabel.snp.height)
        }
    }
}

extension IncidentScoreChangeView {
    
    @discardableResult
    func homeTeamScoreLabelText(_ text: String) -> Self {
        homeTeamScoreLabel.text = text
        return self
    }
    
    @discardableResult
    func awayTeamScoreLabelText(_ text: String) -> Self {
        awayTeamScoreLabel.text = text
        return self
    }
}
