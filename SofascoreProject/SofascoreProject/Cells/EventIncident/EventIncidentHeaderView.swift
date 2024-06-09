//
//  EventIncidentHeaderView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

final class EventIncidentHeaderView: BaseView {
    
    private let grayView: UIView = .init()
    private let incidentHeaderLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(grayView)
        grayView.addSubview(incidentHeaderLabel)
    }
    
    override func setupConstraints() {
        grayView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        incidentHeaderLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(16)
        }
    }
    
    override func styleViews() {
        grayView.backgroundColor = .colorSecondaryHighlight
        grayView.layer.cornerRadius = 8.0
        incidentHeaderLabel.font = .assistive
        incidentHeaderLabel.textAlignment = .center
    }
}

extension EventIncidentHeaderView {
    
    @discardableResult
    func incidentHeaderLabelText(_ text: String) -> Self {
        incidentHeaderLabel.text = text
        return self
    }
    
    @discardableResult
    func incidentHeaderLabelColor(_ color: UIColor) -> Self {
        incidentHeaderLabel.textColor = color
        return self
    }
}
