//
//  NoEventsView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 31.05.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class NoEventsView: BaseView {
    
    private let warningTextLabel: UILabel = .init()
    private let warningImageView: UIImageView = .init()
    
    override func addViews() {
        addSubview(warningTextLabel)
        addSubview(warningImageView)
    }
    
    override func styleViews() {
        warningTextLabel.font = .headline1
        warningTextLabel.textColor = .colorPrimaryDefault
    }
    
    override func setupConstraints() {
        warningImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
        
        warningTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(warningImageView.snp.bottom).offset(40)
        }
    }
}

extension NoEventsView {
    
    @discardableResult
    func warningTextLabelText(_ text: String) -> Self {
        warningTextLabel.text = text
        return self
    }
    
    @discardableResult
    func warningImageViewImage(_ image: UIImage?) -> Self {
        warningImageView.image = image
        return self
    }
}
