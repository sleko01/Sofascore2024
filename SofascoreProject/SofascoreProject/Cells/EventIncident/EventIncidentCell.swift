//
//  EventIncidentCell.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.06.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

struct EventIncidentCellModel {
    
    let incidentImage: String
    let timeOfIncident: Int
    let playerName: String
    let incidentDescription: String?
    let homeScore: Int?
    let awayScore: Int?
    let teamSide: String
    let type: IncidentType
}

final class EventIncidentCell: UITableViewCell, BaseViewProtocol {
    
    static let identifier: String = .init(describing: EventIncidentCell.self)
    
    private let view: EventIncidentView = .init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(view)
    }

    func setupConstraints() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func model(_ model: EventIncidentCellModel) {
        view.getIncidentImageView().image = UIImage(named: model.incidentImage)
        view.getTimeOfIncidentLabel().text = model.timeOfIncident.description
        view.getPlayerNameLabel().text = model.playerName
        view.getIncidentDescriptionLabel().text = model.incidentDescription
        view.getPlayerNameLabel().textAlignment = model.teamSide == .home ? .left : .right
        view.getIncidentDescriptionLabel().textAlignment = model.teamSide == .home ? .left : .right
        view.getScoreChangeView()
            .homeTeamScoreLabelText(model.homeScore?.description ?? "")
            .awayTeamScoreLabelText(model.awayScore?.description ?? "")
        if model.type != .goal {
            view.getScoreChangeView().isHidden = true
            view.getIncidentDescriptionLabel().isHidden = false
        } else {
            view.getScoreChangeView().isHidden = false
            view.getIncidentDescriptionLabel().isHidden = true
        }
        setupChildViewConstraints(model)
    }
    
    private func setupChildViewConstraints(_ model: EventIncidentCellModel) {
        let isHomeTeam = model.teamSide == .home
        
        view.getIncidentImageView().snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            if isHomeTeam {
                $0.leading.equalToSuperview().inset(16)
            } else {
                $0.trailing.equalToSuperview().inset(16)
            }
            $0.width.height.equalTo(24)
        }
        
        view.getTimeOfIncidentLabel().snp.remakeConstraints {
            $0.top.equalTo(view.getIncidentImageView().snp.bottom)
            $0.width.equalTo(40)
            if isHomeTeam {
                $0.leading.equalToSuperview().inset(8)
            } else {
                $0.trailing.equalToSuperview().inset(8)
            }
            $0.bottom.equalToSuperview().inset(8)
        }
        
        view.getDividerView().snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.width.equalTo(1)
            if isHomeTeam {
                $0.leading.equalTo(view.getTimeOfIncidentLabel().snp.trailing).offset(7)
            } else {
                $0.trailing.equalTo(view.getTimeOfIncidentLabel().snp.leading).offset(-7)
            }
            $0.bottom.equalToSuperview().inset(8)
        }
        
        if model.type == .card {
            view.getPlayerNameLabel().snp.remakeConstraints {
                $0.top.equalToSuperview().offset(12)
                if isHomeTeam {
                    $0.leading.equalTo(view.getDividerView().snp.trailing).offset(12)
                    $0.trailing.equalToSuperview().inset(16)
                } else {
                    $0.trailing.equalTo(view.getDividerView().snp.leading).offset(-12)
                    $0.leading.equalToSuperview().inset(16)
                }
                $0.bottom.equalToSuperview().inset(28)
            }
            
            view.getIncidentDescriptionLabel().snp.remakeConstraints {
                $0.top.equalTo(view.getPlayerNameLabel().snp.bottom)
                $0.leading.trailing.equalTo(view.getPlayerNameLabel())
                $0.bottom.equalToSuperview().inset(12)
            }
            view.getScoreChangeView().isHidden = true
        } else if model.type == .goal {
            view.getScoreChangeView().isHidden = false
            
            view.getScoreChangeView().snp.remakeConstraints {
                $0.top.equalToSuperview().offset(14)
                $0.width.equalTo(84)
                if isHomeTeam {
                    $0.leading.equalTo(view.getDividerView().snp.trailing).offset(8)
                } else {
                    $0.trailing.equalTo(view.getDividerView().snp.leading).offset(-8)
                }
                $0.bottom.equalToSuperview().inset(14)
            }
            
            view.getPlayerNameLabel().snp.remakeConstraints {
                if isHomeTeam {
                    $0.leading.equalTo(view.getScoreChangeView().snp.trailing).offset(8)
                    $0.trailing.equalToSuperview().inset(16)
                } else {
                    $0.trailing.equalTo(view.getScoreChangeView().snp.leading).offset(-8)
                    $0.leading.equalToSuperview().inset(16)
                }
                $0.centerY.equalToSuperview()
            }
        }
    }

}

