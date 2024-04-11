//
//  HeaderView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class HeaderView: BaseView {
    
    private let appLogo: UIImageView = .init()
    private let trophyIcon: UIImageView = .init()
    private let settingsButton: UIButton = .init()
    
    private var buttonAction: (() -> Void)?
    
    override func addViews() {
        addSubview(appLogo)
        addSubview(trophyIcon)
        addSubview(settingsButton)
    }
    
    override func setupConstraints() {
        appLogo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(132)
        }
        
        trophyIcon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(24)
            $0.trailing.equalToSuperview().inset(64)
        }
        
        settingsButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(24)
        }
    }
    
    override func styleViews() {
        settingsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        buttonAction?()
    }
}

extension HeaderView {
    
    @discardableResult
    func appLogoImageName(_ name: String) -> Self {
        appLogo.image = UIImage(named: name)
        return self
    }
    
    @discardableResult
    func trophyIconImageName(_ name: String) -> Self {
        trophyIcon.image = UIImage(named: name)
        return self
    }
    
    @discardableResult
    func settingsButtonImageName(_ name: String) -> Self {
        settingsButton.setImage(UIImage(named: name), for: .normal)
        return self
    }
    
    @discardableResult
    func setButtonAction(_ closure: (() -> Void)?) -> Self {
        buttonAction = closure
        return self
    }
}
