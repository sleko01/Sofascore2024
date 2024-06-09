//
//  UpcomingEventView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 03.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class UpcomingEventView: BaseView {
    
    private let dateLabel: UILabel = .init()
    private let matchStartTimeLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(dateLabel)
        addSubview(matchStartTimeLabel)
    }
    
    override func styleViews() {
        dateLabel.font = .micro
        dateLabel.textColor = .onSurfaceOnSurfaceLv1
        dateLabel.textAlignment = .center
        matchStartTimeLabel.font = .micro
        matchStartTimeLabel.textColor = .onSurfaceOnSurfaceLv1
        matchStartTimeLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        matchStartTimeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
    }
}

extension UpcomingEventView {
    
    @discardableResult
    func dateLabelText(_ text: String) -> Self {
        dateLabel.text = text
        return self
    }
    
    @discardableResult
    func matchStartTimeLabelText(_ text: String) -> Self {
        matchStartTimeLabel.text = text
        return self
    }
}
