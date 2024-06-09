//
//  SimpleTournamentView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class SimpleTournamentView: BaseView {
    
    private let tournamentNameLabel: UILabel = .init()
    private let tournamentLogoImageView: UIImageView = .init()
    
    override func addViews() {
        addSubview(tournamentNameLabel)
        addSubview(tournamentLogoImageView)
    }
    
    override func styleViews() {
        tournamentNameLabel.font = .micro
        tournamentNameLabel.textColor = .onSurfaceOnSurfaceLv2
        tournamentNameLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        tournamentLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(40)
        }
        
        tournamentNameLabel.snp.makeConstraints {
            $0.top.equalTo(tournamentLogoImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo(96)
        }
    }
}

extension SimpleTournamentView {
    
    @discardableResult
    func tournamentNameLabelText(_ text: String) -> Self {
        tournamentNameLabel.text = text
        return self
    }
    
    @discardableResult
    func tournamentImage(_ image: UIImage?) -> Self {
        tournamentLogoImageView.image = image
        return self
    }
}
