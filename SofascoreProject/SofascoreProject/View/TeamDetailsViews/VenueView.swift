//
//  VenueView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class VenueView: BaseView {
    
    private let stadiumLabel: UILabel = .init()
    private let stadiumNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(stadiumLabel)
        addSubview(stadiumNameLabel)
    }
    
    override func styleViews() {
        stadiumLabel.font = .body
        stadiumLabel.textColor = .onSurfaceOnSurfaceLv1
        stadiumLabel.text = "Stadium"
        
        stadiumNameLabel.font = .body
        stadiumNameLabel.textColor = .onSurfaceOnSurfaceLv1
    }
    
    override func setupConstraints() {
        stadiumLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(160)
        }
        
        stadiumNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(114)
        }
    }
}

extension VenueView {
    
    @discardableResult
    func stadiumNameLabelText(_ text: String) -> Self {
        stadiumNameLabel.text = text
        return self
    }
}
