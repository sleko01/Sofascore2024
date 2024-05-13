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
    
    override public func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    public override func styleViews() {
        teamLogoImageView.contentMode = .scaleAspectFit
    }

    override public func setupConstraints() {
        teamLogoImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLogoImageView.snp.trailing).offset(8)
            $0.top.equalTo(teamLogoImageView.snp.top)
            $0.bottom.equalTo(teamLogoImageView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
    }

    @discardableResult
    func teamLogo(_ image: UIImage?) -> Self {
        teamLogoImageView.image = image
        return self
    }

    @discardableResult
    func teamName(_ text: String) -> Self {
        teamNameLabel.text = text
        return self
    }

    @discardableResult
    func teamNameColor(_ color: UIColor) -> Self {
        teamNameLabel.textColor = color
        return self
    }
}
