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
    private let isSportSelectedView: UIView = .init()
    
    private var onTap: (() -> Void)?
    
    override func addViews() {
        addSubview(sportIconImageView)
        addSubview(sportNameLabel)
        addSubview(isSportSelectedView)
    }
    
    override func styleViews() {
        sportNameLabel.textColor = .white
        sportNameLabel.font = .robotoRegular
        sportNameLabel.textAlignment = .center
        isSportSelectedView.backgroundColor = .white
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func setupConstraints() {
        sportIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
            $0.height.width.equalTo(16)
        }
        
        sportNameLabel.snp.makeConstraints {
            $0.top.equalTo(sportIconImageView.snp.bottom).offset(4)
            $0.bottom.equalTo(isSportSelectedView.snp.top).inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        isSportSelectedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(4)
        }
    }
    
    @objc
    func handleTap() {
        onTap?()
    }
}

extension TabItemView {
    
    @discardableResult
    func sportsIcon(_ icon: String) -> Self {
        sportIconImageView.image = UIImage(named: icon)
        return self
    }
    
    @discardableResult
    func sportName(_ name: String) -> Self {
        sportNameLabel.text = name
        return self
    }
    
    func getSportName() -> String {
        return sportNameLabel.text!
    }
    
    @discardableResult
    func isSportSelected(_ selection: Bool) -> Self {
        isSportSelectedView.isHidden = !selection
        return self
    }
    
    @discardableResult
    func setTapHandleAction(_ closure: (() -> Void)?) -> Self {
        onTap = closure
        return self
    }
}
