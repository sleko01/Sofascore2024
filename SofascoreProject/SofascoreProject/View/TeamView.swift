//
//  TeamView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 17.03.2024..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

public class TeamView: BaseView {
    
    private let teamLogoImageView: UIImageView = .init()
    private let teamNameLabel: UILabel = .init()
    
    func teamLogo (_ image: UIImage) {
        teamLogoImageView.image = image
    }
    
    func teamName (_ name: String) {
        teamNameLabel.text = name
    }
    
    func teamNameColor(_ color: UIColor) {
        teamNameLabel.textColor = color
    }
    
    override public func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override public func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(16)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
}
