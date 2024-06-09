//
//  TeamTournamentView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamTournamentView: BaseView {
    
    private let tournamentImageView: UIImageView = .init()
    private let tournamentNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(tournamentImageView)
        addSubview(tournamentNameLabel)
    }
    
    override func styleViews() {
        tournamentNameLabel.font = .micro
        tournamentNameLabel.textColor = .onSurfaceOnSurfaceLv2
    }
    
    override func setupConstraints() {
        tournamentImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(48)
        }
        
        tournamentNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tournamentImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

extension TeamTournamentView {
    
    @discardableResult
    func tournamentImage(_ image: UIImage) -> Self {
        tournamentImageView.image = image
        return self
    }
    
    @discardableResult
    func tournamentNameLabelText(_ text: String) -> Self {
        tournamentNameLabel.text = text
        return self
    }
}
