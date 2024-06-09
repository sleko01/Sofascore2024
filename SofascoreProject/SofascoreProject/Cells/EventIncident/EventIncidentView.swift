//
//  EventIncidentView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

final class EventIncidentView: BaseView {
    
    private let incidentImageView: UIImageView = .init()
    private let timeOfIncidentLabel: UILabel = .init()
    private let dividerView: UIView = .init()
    private let playerNameLabel: UILabel = .init()
    private let incidentDescriptionLabel: UILabel = .init()
    private let scoreChangeView: IncidentScoreChangeView = .init()
    
    override func addViews() {
        addSubview(incidentImageView)
        addSubview(timeOfIncidentLabel)
        addSubview(dividerView)
        addSubview(playerNameLabel)
        addSubview(incidentDescriptionLabel)
        addSubview(scoreChangeView)
    }
    
    override func styleViews() {
        timeOfIncidentLabel.font = .micro
        timeOfIncidentLabel.textColor = .onSurfaceOnSurfaceLv2
        timeOfIncidentLabel.textAlignment = .center
        playerNameLabel.font = .body
        playerNameLabel.textColor = .onSurfaceOnSurfaceLv1
        incidentDescriptionLabel.font = .micro
        incidentDescriptionLabel.textColor = .onSurfaceOnSurfaceLv2
        dividerView.backgroundColor = .onSurfaceOnSurfaceLv4
    }
}

extension EventIncidentView {
    
    func getIncidentImageView() -> UIImageView {
        return incidentImageView
    }
    
    func getTimeOfIncidentLabel() -> UILabel {
        return timeOfIncidentLabel
    }
    
    func getDividerView() -> UIView {
        return dividerView
    }
    
    func getPlayerNameLabel() -> UILabel {
        return playerNameLabel
    }
    
    func getIncidentDescriptionLabel() -> UILabel {
        return incidentDescriptionLabel
    }
    
    func getScoreChangeView() -> IncidentScoreChangeView {
        return scoreChangeView
    }
}
