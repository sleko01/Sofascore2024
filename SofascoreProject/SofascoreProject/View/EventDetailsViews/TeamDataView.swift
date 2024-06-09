//
//  TeamDataView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 03.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDataView: BaseView {
    
    private let teamLogoImageView: UIImageView = .init()
    private let teamNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamNameLabel.font = .assistive
        teamNameLabel.textColor = .onSurfaceOnSurfaceLv1
        teamNameLabel.textAlignment = .center
        teamNameLabel.numberOfLines = 2
    }
    
    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.width.equalTo(40)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(teamLogoImageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TeamDataView {
    
    @discardableResult
    func teamNameLabelText(_ text: String) -> Self {
        teamNameLabel.text = text
        return self
    }
    
    @discardableResult
    func teamLogoImage(_ image: UIImage?) -> Self {
        teamLogoImageView.image = image
        return self
    }
}
