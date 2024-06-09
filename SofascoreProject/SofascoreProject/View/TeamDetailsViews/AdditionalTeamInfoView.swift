//
//  AdditionalTeamInfoView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic


class AdditionalTeamInfoView: BaseView {
    
    private let infoImageView: UIImageView = .init()
    private let infoNumberLabel: UILabel = .init()
    private let infoDescriptionLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(infoImageView)
        addSubview(infoNumberLabel)
        addSubview(infoDescriptionLabel)
    }
    
    override func styleViews() {
        infoNumberLabel.font = .headline3
        infoNumberLabel.textColor = .colorPrimaryDefault
        infoNumberLabel.textAlignment = .center
        infoDescriptionLabel.font = .micro
        infoDescriptionLabel.textColor = .onSurfaceOnSurfaceLv2
        infoDescriptionLabel.textAlignment = .center
    }
    
    override func setupConstraints() {        
        infoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(40)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(68)
        }
        
        infoNumberLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoImageView.snp.bottom).offset(8)
            $0.height.equalTo(16)
        }
        
        infoDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32)
            $0.top.equalTo(infoNumberLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
    }
}

extension AdditionalTeamInfoView {
    
    @discardableResult
    func infoImage(_ image: UIImage) -> Self {
        infoImageView.image = image
        return self
    }
    
    @discardableResult
    func infoNumberLabelText(_ text: String) -> Self {
        infoNumberLabel.text = text
        return self
    }
    
    @discardableResult
    func infoDescriptionLabelText(_ text: String) -> Self {
        infoDescriptionLabel.text = text
        return self
    }
}
