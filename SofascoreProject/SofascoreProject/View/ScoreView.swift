//
//  ScoreView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import SofaAcademic
import UIKit

public class ScoreView: BaseView {
    let team1Score: Int?
    let team2Score: Int?
    let inProgress: Bool
    let team1ScoreView: UILabel = .init()
    let team2ScoreView: UILabel = .init()
    
    init(team1Score: Int?, team2Score: Int?, inProgress: Bool) {
        self.team1Score = team1Score
        self.team2Score = team2Score
        self.inProgress = inProgress
        if let score = team1Score {
            team1ScoreView.text = String(score)
        } else {
            team1ScoreView.text = ""
        }
        
        if let score = team2Score {
            team2ScoreView.text = String(score)
        } else {
            team2ScoreView.text = ""
        }
        
        super.init()
    }
    
    public override func addViews() {
        addSubview(team1ScoreView)
        addSubview(team2ScoreView)
    }
    
    public override func styleViews() {
        team1ScoreView.font = ViewUtilities.robotoRegular
        team2ScoreView.font = ViewUtilities.robotoRegular
        team1ScoreView.textAlignment = .right
        team2ScoreView.textAlignment = .right
        if inProgress {
            team1ScoreView.textColor = ViewUtilities.red
            team2ScoreView.textColor = ViewUtilities.red
        } else {
            if let t1score = team1Score, let t2score = team2Score {
                // game finished
                if t1score > t2score {
                    team1ScoreView.textColor = ViewUtilities.black
                    team2ScoreView.textColor = ViewUtilities.grey
                } else {
                    team1ScoreView.textColor = ViewUtilities.grey
                    team2ScoreView.textColor = ViewUtilities.black
                }
            }
        }
    }
    
    public override func setupConstraints() {
        team1ScoreView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview()
        }
        
        team2ScoreView.snp.makeConstraints {
            $0.top.equalTo(team1ScoreView.snp.bottom).offset(4)
            $0.height.equalTo(16)
            $0.width.equalTo(32)
            $0.trailing.equalToSuperview()
        }
    }
    
    
}
