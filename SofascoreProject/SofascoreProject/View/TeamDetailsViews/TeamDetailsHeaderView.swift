//
//  TeamDetailsHeaderView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsHeaderView: BaseView {
    
    private let backButton: UIButton = .init()
    private let backButtonImageView: UIImageView = .init()
    private let teamLogoImageView: UIImageView = .init()
    private let teamLogoImageViewBackground: UIView = .init()
    private let teamNameLabel: UILabel = .init()
    private let countryFlagImageView: UIImageView = .init()
    private let countryNameLabel: UILabel = .init()
    private var buttonAction: (() -> Void)?
    
    override func addViews() {
        addSubview(backButton)
        addSubview(teamLogoImageViewBackground)
        addSubview(teamNameLabel)
        addSubview(countryFlagImageView)
        addSubview(countryNameLabel)
        backButton.addSubview(backButtonImageView)
        teamLogoImageViewBackground.addSubview(teamLogoImageView)
    }
    
    override func styleViews() {
        backButtonImageView.image = .backButtonWhite
        countryFlagImageView.image = .spain
        countryFlagImageView.layer.cornerRadius = 8.0
        teamLogoImageViewBackground.backgroundColor = .surfaceSurface1
        teamLogoImageViewBackground.layer.cornerRadius = 8.0
        teamNameLabel.font = .headline1
        teamNameLabel.textColor = .surfaceSurface1
        countryNameLabel.font = .headline3
        countryNameLabel.textColor = .surfaceSurface1
    }
    
    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
        
        backButtonImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        teamLogoImageViewBackground.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(56)
        }
        
        teamLogoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalTo(teamLogoImageViewBackground.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        countryFlagImageView.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(teamLogoImageViewBackground.snp.trailing).offset(16)
            $0.width.height.equalTo(16)
        }
        
        countryNameLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(countryFlagImageView.snp.trailing).offset(4)
            $0.height.equalTo(16)
        }
    }
    
    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        buttonAction?()
    }
}

extension TeamDetailsHeaderView {
    
    @discardableResult
    func teamLogoImage(_ image: UIImage) -> Self {
        teamLogoImageView.image = image
        return self
    }
    
    @discardableResult
    func teamNameLabelText(_ text: String) -> Self {
        teamNameLabel.text = text
        return self
    }
    
    @discardableResult
    func countryNameLabelText(_ text: String) -> Self {
        countryNameLabel.text = text
        return self
    }
    
    @discardableResult
    func setButtonAction(_ closure: (() -> Void)?) -> Self {
        buttonAction = closure
        return self
    }
}
