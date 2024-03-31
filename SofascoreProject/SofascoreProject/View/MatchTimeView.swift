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
    
    private let matchStartLabel: UILabel = .init()
    private let currentMatchTimeOrStatusLabel: UILabel = .init()
    
    override public func addViews() {
        addSubview(matchStartLabel)
        addSubview(currentMatchTimeOrStatusLabel)
    }
    
    func matchStartTime(_ startTime: String) {
        matchStartLabel.text = startTime
    }
    
    func statusLabel(_ currentTime: String) {
        currentMatchTimeOrStatusLabel.text = currentTime
    }
    
    func currentMatchTimeColor(_ color: UIColor) {
        currentMatchTimeOrStatusLabel.textColor = color
    }
    
    override public func styleViews() {
        matchStartLabel.textAlignment = .center
        matchStartLabel.font = .robotoCondensed
        currentMatchTimeOrStatusLabel.textAlignment = .center
        currentMatchTimeOrStatusLabel.font = .robotoCondensed
        matchStartLabel.textColor = .grey
    }
    
    override public func setupConstraints() {
        matchStartLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
        currentMatchTimeOrStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchStartLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
        }
    }
}
