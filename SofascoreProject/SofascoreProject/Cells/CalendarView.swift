//
//  CalendarView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 10.05.2024..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

final class CalendarView: BaseView {

    private let dayOfWeekLabel: UILabel = .init()
    private let dateLabel: UILabel = .init()
    private let selectedDateIndicator: UIView = .init()

    override func addViews() {
        addSubview(dayOfWeekLabel)
        addSubview(dateLabel)
        addSubview(selectedDateIndicator)
    }

    override func styleViews() {
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.textColor = .surfaceSurface1
        dayOfWeekLabel.font = .micro
        dateLabel.textAlignment = .center
        dateLabel.textColor = .surfaceSurface1
        dateLabel.font = .micro
        
        selectedDateIndicator.backgroundColor = .surfaceSurface1
        selectedDateIndicator.isHidden = true
    }

    override func setupConstraints() {
        dayOfWeekLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(4)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayOfWeekLabel.snp.bottom)
            $0.leading.equalTo(dayOfWeekLabel.snp.leading)
            $0.trailing.equalTo(dayOfWeekLabel.snp.trailing)
        }
        
        selectedDateIndicator.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }

    func showIndicator() {
        selectedDateIndicator.isHidden = false
    }

    func hideIndicator() {
        selectedDateIndicator.isHidden = true
    }
}

extension CalendarView {
    @discardableResult
    func dayOfWeekText(_ text: String) -> Self {
        dayOfWeekLabel.text = text
        return self
    }

    @discardableResult
    func dateText(_ text: String) -> Self {
        dateLabel.text = text
        return self
    }
}
