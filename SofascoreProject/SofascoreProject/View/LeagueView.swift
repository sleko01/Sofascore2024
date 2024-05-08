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
    
    private var logoImageView: UIImageView = .init()
    private var countryAndNameHolderView : CountryAndNameHolderView = .init()

    override public func addViews() {
        addSubview(logoImageView)
        addSubview(countryAndNameHolderView)
    }
    
    override public func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(32)
        }
        
        countryAndNameHolderView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.bottom.equalTo(logoImageView.snp.bottom)
        }
    }
    
    func leagueLogo(_ image: UIImage?) {
        logoImageView.image = image
    }
    
    func countryName (_ name: String) {
        countryAndNameHolderView.tournamentCountryName(name)
    }
    
    func leagueName (_ name: String) {
        countryAndNameHolderView.tournamentName(name)
    }
    
    func holderRightPointerImage(_ image: UIImage) {
        countryAndNameHolderView.rightPointerImage(image)
    }
}
