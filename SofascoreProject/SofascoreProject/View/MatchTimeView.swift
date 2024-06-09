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
    
    override public func styleViews() {
        matchStartLabel.textAlignment = .center
        matchStartLabel.font = .micro
        matchStartLabel.textColor = .onSurfaceOnSurfaceLv2

        currentMatchTimeOrStatusLabel.textAlignment = .center
        currentMatchTimeOrStatusLabel.font = .micro
    }
    
    override public func setupConstraints() {
        matchStartLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(16)
        }

        currentMatchTimeOrStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchStartLabel.snp.bottom).offset(4)
            $0.leading.equalTo(matchStartLabel.snp.leading)
            $0.trailing.equalTo(matchStartLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(10)
        }
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
}
