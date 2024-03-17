//
//  CountryAndNameHolder.swift
//  SofascoreProject
//
//  Created by Sven Leko on 16.03.2024..
//

import Foundation
import SofaAcademic
import UIKit

public class CountryAndNameHolder : BaseView {
    var country: UILabel = .init()
    var name: UILabel = .init()
    let rightPointer: UIImageView = .init()
    
    public override func addViews() {
        addSubview(country)
        addSubview(rightPointer)
        addSubview(name)
    }
    
    public override func styleViews() {
        country.font = ViewUtilities.robotoBold
        name.font = ViewUtilities.robotoBold
        country.textColor = ViewUtilities.black
        name.textColor = ViewUtilities.grey
        
        // this is to ensure that the width of the country is dynamic according to the country name length
        country.setContentHuggingPriority(.required, for: .horizontal)
        country.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    public override func setupConstraints() {
        country.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
        }
        
        rightPointer.snp.makeConstraints {
            $0.leading.equalTo(country.snp.trailing)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(rightPointer.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview()
        }
    }
}
