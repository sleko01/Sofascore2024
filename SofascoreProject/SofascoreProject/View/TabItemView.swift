//
//  TabItemView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 11.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TabItemView: BaseView {
    
    private let sportIconImageView: UIImageView = .init()
    private let sportNameLabel: UILabel = .init()

    private var onTap: (() -> Void)?
    
    override func addViews() {
        addSubview(sportIconImageView)
        addSubview(sportNameLabel)
    }
    
    override func styleViews() {
        sportNameLabel.textColor = .white
        sportNameLabel.font = .robotoRegular
        sportNameLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        sportIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
            $0.height.width.equalTo(16)
        }
        
        sportNameLabel.snp.makeConstraints {
            $0.top.equalTo(sportIconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func setupGestureRecognizers() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc
    func handleTap() {
        onTap?()
    }
}

extension TabItemView {
    
    @discardableResult
    func sportsIcon(_ icon: UIImage) -> Self {
        sportIconImageView.image = icon
        return self
    }
    
    @discardableResult
    func sportName(_ name: String) -> Self {
        sportNameLabel.text = name
        return self
    }
    
    @discardableResult
    func setTapHandleAction(_ closure: (() -> Void)?) -> Self {
        onTap = closure
        return self
    }
}
