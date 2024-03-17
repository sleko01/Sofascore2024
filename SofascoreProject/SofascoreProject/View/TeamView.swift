//
//  TeamView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import SofaAcademic
import UIKit

public class TeamView: BaseView {
    let teamLogo: UIImageView = .init()
    let teamName: UILabel = .init()
    var teamWinLossStatus: Bool // true if team won or game not finished, false if team lost or drew
    
    init(teamWinLossStatus: Bool) {
        self.teamWinLossStatus = teamWinLossStatus
        super.init()
    }
    
    public override func addViews() {
        addSubview(teamLogo)
        addSubview(teamName)
    }
    
    public override func styleViews() {
        teamName.textColor = teamWinLossStatus ? ViewUtilities.black : ViewUtilities.grey
    }
    
    public override func setupConstraints() {
        teamLogo.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(16)
        }
        
        teamName.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.bottom.width.equalToSuperview()
        }
    }
}
