//
//  CoachView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class CoachView: BaseView {
    
    private let coachImageView: UIImageView = .init()
    private let coachNameLabel: UILabel = .init()
    private let countryFlagImageView: UIImageView = .init()
    private let countryNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(coachImageView)
        addSubview(coachNameLabel)
        addSubview(countryFlagImageView)
        addSubview(countryNameLabel)
    }
    
    override func styleViews() {
        coachNameLabel.font = .headline3
        coachNameLabel.textColor = .onSurfaceOnSurfaceLv1
        countryNameLabel.font = .assistive
        countryNameLabel.textColor = .onSurfaceOnSurfaceLv2
        coachImageView.image = .spain
        countryFlagImageView.image = .spain
        countryNameLabel.text = "Spain"
    }
    
    override func setupConstraints() {
        coachImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(40)
        }
        
        coachNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(coachImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        countryFlagImageView.snp.makeConstraints {
            $0.top.equalTo(coachNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(coachImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(16)
        }
        
        countryNameLabel.snp.makeConstraints {
            $0.top.equalTo(coachNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(countryFlagImageView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension CoachView {
    
    @discardableResult
    func coachNameLabelText(_ text: String) -> Self {
        coachNameLabel.text = text
        return self
    }
    
    @discardableResult
    func countryNameLabelText(_ text: String) -> Self {
        countryNameLabel.text = text
        return self
    }
}
