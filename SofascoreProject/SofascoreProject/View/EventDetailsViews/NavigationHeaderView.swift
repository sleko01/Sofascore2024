//
//  NavigationHeaderView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 03.06.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class NavigationHeaderView: BaseView {
    
    private let backButton: UIButton = .init()
    private let tournamentImageView: UIImageView = .init()
    private let descriptionLabel: UILabel = .init()
    private var buttonAction: (() -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(tournamentImageView)
        addSubview(descriptionLabel)
    }
    
    override func styleViews() {
        // logic here on purpose; no point in setting the back button image every time I need this view as it is always the same back button
        backButton.setImage(UIImage(resource: .backButton), for: .normal)
        descriptionLabel.font = .micro
        descriptionLabel.textColor = .onSurfaceOnSurfaceLv2
    }
    
    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
        }
        
        tournamentImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(backButton)
            $0.leading.equalTo(backButton.snp.trailing).offset(24)
            $0.width.height.equalTo(backButton.snp.height)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(backButton)
            $0.leading.equalTo(tournamentImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        buttonAction?()
    }
}

extension NavigationHeaderView {
    @discardableResult
    func tournamentImage(_ image: UIImage?) -> Self {
        tournamentImageView.image = image
        return self
    }
    
    @discardableResult
    func descriptionLabelText(_ text: String?) -> Self {
        descriptionLabel.text = text
        return self
    }
    
    @discardableResult
    func setButtonAction(_ closure: (() -> Void)?) -> Self {
        buttonAction = closure
        return self
    }
}
