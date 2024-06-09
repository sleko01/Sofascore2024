//
//  EventIncidentHeaderCell.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

struct EventIncidentHeaderModel {
    
    let incidentHeaderLabelText: String
    let status: MatchStatus
}

final class EventIncidentHeaderCell: UITableViewHeaderFooterView, BaseViewProtocol {
    
    static let identifier: String = .init(describing: EventIncidentHeaderCell.self)
    
    private let view: EventIncidentHeaderView = .init()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
    
    func model(_ model: EventIncidentHeaderModel) {
        view
            .incidentHeaderLabelText(model.incidentHeaderLabelText)
            .incidentHeaderLabelColor(model.status == .finished ? .onSurfaceOnSurfaceLv1 : .specificLive)
    }
}
