//
//  InfoView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class InfoView: BaseView {
    
    private let infoLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(infoLabel)
    }
    
    override func styleViews() {
        infoLabel.font = .headline2
        infoLabel.textColor = .onSurfaceOnSurfaceLv1
        infoLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

extension InfoView {
    
    @discardableResult
    func infoLabelText(_ text: String) -> Self {
        infoLabel.text = text
        return self
    }
}
