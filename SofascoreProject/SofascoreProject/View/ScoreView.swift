//
//  ScoreView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

public class ScoreView: BaseView {
    
    private let homeTeamScoreView: UILabel = .init()
    private let awayTeamScoreView: UILabel = .init()
    
    func homeTeamScore(_ score: String) {
        homeTeamScoreView.text = score
    }

    func homeTeamScoreColor(_ color: UIColor) {
        homeTeamScoreView.textColor = color
    }

    func awayTeamScore(_ score: String) {
        awayTeamScoreView.text = score
    }

    func awayTeamTextColor(_ color: UIColor) {
        awayTeamScoreView.textColor = color
    }
    
    public override func addViews() {
        addSubview(homeTeamScoreView)
        addSubview(awayTeamScoreView)
    }
    
    public override func styleViews() {
        homeTeamScoreView.font = .robotoRegular
        awayTeamScoreView.font = .robotoRegular
        homeTeamScoreView.textAlignment = .right
        awayTeamScoreView.textAlignment = .right
    }
    
    public override func setupConstraints() {
        homeTeamScoreView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview()
        }
        
        awayTeamScoreView.snp.makeConstraints {
            $0.top.equalTo(homeTeamScoreView.snp.bottom).offset(4)
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview()
        }
    }
}
