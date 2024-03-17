//
//  MatchTimeView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

public class MatchTimeView: BaseView {
    let matchStart: UILabel = .init()
    let currentMatchTimeOrStatus: UILabel = .init()
    let matchInProgress: Bool
    
    init(matchInProgress: Bool) {
        self.matchInProgress = matchInProgress
        super.init()
    }
    
    public override func addViews() {
        addSubview(matchStart)
        addSubview(currentMatchTimeOrStatus)
    }
    
    public override func styleViews() {
        if matchInProgress {
            currentMatchTimeOrStatus.textColor = ViewUtilities.red
        } else {
            currentMatchTimeOrStatus.textColor = ViewUtilities.grey
        }
        matchStart.textAlignment = .center
        matchStart.font = ViewUtilities.robotoCondensed
        currentMatchTimeOrStatus.textAlignment = .center
        currentMatchTimeOrStatus.font = ViewUtilities.robotoCondensed
        matchStart.textColor = ViewUtilities.grey
    }
    
    public override func setupConstraints() {
        matchStart.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        currentMatchTimeOrStatus.snp.makeConstraints {
            $0.top.equalTo(matchStart.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
}
