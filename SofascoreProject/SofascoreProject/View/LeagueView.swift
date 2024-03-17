//
//  LeagueView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 15.03.2024..
//

import Foundation
import SofaAcademic
import SnapKit
import UIKit

public class LeagueView: BaseView {
    var logo: UIImageView = .init()
    var countryAndNameHolder : CountryAndNameHolder = .init()
    
    
    override public func addViews() {
        addSubview(logo)
        addSubview(countryAndNameHolder)
    }
    
    override public func setupConstraints() {
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(32)
        }
        
        countryAndNameHolder.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(80)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.equalToSuperview().offset(-129)
        }
    }
    
    
}
