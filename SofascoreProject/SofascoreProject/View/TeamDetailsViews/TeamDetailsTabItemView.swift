//
//  TeamDetailsTabItemView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsTabItemView: TabItemView {
    
    private let tabNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(tabNameLabel)
    }
    
    override func setupConstraints() {
        tabNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func styleViews() {
        super.styleViews()
        tabNameLabel.textColor = .surfaceSurface0
        tabNameLabel.font = .body
        tabNameLabel.textAlignment = .center
    }
}

extension TeamDetailsTabItemView {
    
    @discardableResult
    func tabNameLabelText(_ text: String) -> Self {
        tabNameLabel.text = text
        return self
    }
}
