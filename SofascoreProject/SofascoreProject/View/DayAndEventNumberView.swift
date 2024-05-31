//
//  DayAndEventNumberView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 29.05.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class DayAndEventNumberView: BaseView {
    
    private let dayLabel: UILabel = .init()
    private let eventNumberLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(dayLabel)
        addSubview(eventNumberLabel)
    }
    
    override func setupConstraints() {
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        eventNumberLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(dayLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func styleViews() {
        dayLabel.font = .assistive
        dayLabel.textColor = .onSurfaceOnSurfaceLv1
        
        eventNumberLabel.font = .assistive
        eventNumberLabel.textColor = .onSurfaceOnSurfaceLv2
    }
}

extension DayAndEventNumberView {
    
    @discardableResult
    func dayLabelText(_ text: String) -> Self {
        dayLabel.text = text
        return self
    }
    
    @discardableResult
    func eventNumberLabelText(_ text: String) -> Self {
        eventNumberLabel.text = text
        return self
    }
}
