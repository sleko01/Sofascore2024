//
//  TournamentView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 29.05.2024..
//

import Foundation
import SnapKit
import UIKit
import SofaAcademic

final class TournamentView: BaseView {
    
    private var logoImageView: UIImageView = .init()
    private var countryAndNameHolderView : CountryAndNameHolderView = .init()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryAndNameHolderView)
    }
    
    override func setupConstraints() {
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
}

extension TournamentView {
    
    @discardableResult
    func leagueLogo(_ image: UIImage?) -> Self {
        logoImageView.image = image
        return self
    }
    
    @discardableResult
    func countryName(_ name: String) -> Self {
        countryAndNameHolderView.tournamentCountryName(name)
        return self
    }
    
    @discardableResult
    func tournamentName(_ name: String) -> Self {
        countryAndNameHolderView.tournamentName(name)
        return self
    }
    
    @discardableResult
    func holderRightPointerImage(_ image: UIImage) -> Self {
        countryAndNameHolderView.rightPointerImage(image)
        return self
    }

}

