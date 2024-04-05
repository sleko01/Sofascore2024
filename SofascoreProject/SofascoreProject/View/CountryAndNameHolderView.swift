//
//  CountryAndNameHolder.swift
//  SofascoreProject
//
//  Created by Sven Leko on 16.03.2024..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

public class CountryAndNameHolderView : BaseView {
    
    private var tournamentCountryNameLabel: UILabel = .init()
    private var tournamentNameLabel: UILabel = .init()
    private let rightPointerImageView: UIImageView = .init()
    
    func tournamentCountryName(_ country: String) {
        tournamentCountryNameLabel.text = country
    }
    
    func tournamentName (_ name: String) {
        tournamentNameLabel.text = name
    }
    
    func rightPointerImage(_ pointerImage: UIImage) {
        rightPointerImageView.image = pointerImage
    }
    
    override public func addViews() {
        addSubview(tournamentCountryNameLabel)
        addSubview(rightPointerImageView)
        addSubview(tournamentNameLabel)
    }
    
    override public func styleViews() {
        tournamentCountryNameLabel.font = .robotoBold
        tournamentNameLabel.font = .robotoBold
        tournamentCountryNameLabel.textColor = .black
        tournamentNameLabel.textColor = .grey
        
        // this is to ensure that the width of the country is dynamic according to the country name length
        tournamentCountryNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        tournamentCountryNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override public func setupConstraints() {
        tournamentCountryNameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
        }
        
        rightPointerImageView.snp.makeConstraints {
            $0.leading.equalTo(tournamentCountryNameLabel.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        tournamentNameLabel.snp.makeConstraints {
            $0.leading.equalTo(rightPointerImageView.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview()
        }
    }
}
