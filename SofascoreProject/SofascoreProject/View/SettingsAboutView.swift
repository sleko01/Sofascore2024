//
//  SettingsAboutView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 31.05.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class SettingsAboutView: BaseView {
    
    private let aboutLabel: UILabel = .init()
    private let platformNameLabel: UILabel = .init()
    private let classLabel: UILabel = .init()
    private let appNameLabel: UILabel = .init()
    private let myAppNameLabel: UILabel = .init()
    private let apiCreditLabel: UILabel = .init()
    private let sofascoreLabel: UILabel = .init()
    private let developerLabel: UILabel = .init()
    private let developerNameLabel: UILabel = .init()
    private let firstDividerView: UIView = .init()
    private let secondDividerView: UIView = .init()
    private let sofascoreImageView: UIImageView = .init()
    private let logOutButton: UIButton = .init()
    private var buttonAction: (() -> Void)?

    override func addViews() {
        addSubview(aboutLabel)
        addSubview(platformNameLabel)
        addSubview(classLabel)
        addSubview(appNameLabel)
        addSubview(myAppNameLabel)
        addSubview(apiCreditLabel)
        addSubview(sofascoreLabel)
        addSubview(developerLabel)
        addSubview(developerNameLabel)
        addSubview(firstDividerView)
        addSubview(secondDividerView)
        addSubview(sofascoreImageView)
        addSubview(logOutButton)
    }
    
    override func styleViews() {
        aboutLabel.font = .headline1
        platformNameLabel.font = .headline2
        classLabel.font = .bodyParagraph
        appNameLabel.font = .assistive
        myAppNameLabel.font = .assistive
        apiCreditLabel.font = .assistive
        sofascoreLabel.font = .bodyParagraph
        developerLabel.font = .assistive
        developerNameLabel.font = .bodyParagraph
        
        aboutLabel.textColor = .onSurfaceOnSurfaceLv1
        platformNameLabel.textColor = .onSurfaceOnSurfaceLv1
        classLabel.textColor = .onSurfaceOnSurfaceLv1
        appNameLabel.textColor = .onSurfaceOnSurfaceLv2
        myAppNameLabel.textColor = .onSurfaceOnSurfaceLv1
        apiCreditLabel.textColor = .onSurfaceOnSurfaceLv2
        sofascoreLabel.textColor = .onSurfaceOnSurfaceLv1
        developerLabel.textColor = .onSurfaceOnSurfaceLv2
        developerNameLabel.textColor = .onSurfaceOnSurfaceLv1
        
        firstDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        secondDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        logOutButton.tintColor = .statusError
        logOutButton.setTitleColor(.black, for: .normal)
        
        logOutButton.layer.borderColor = UIColor.statusError.cgColor
        logOutButton.layer.borderWidth = 2.0
        logOutButton.layer.cornerRadius = 8.0
        
        
    }
    
    override func setupConstraints() {
        aboutLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        
        platformNameLabel.snp.makeConstraints {
            $0.top.equalTo(aboutLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(20)
        }
        
        classLabel.snp.makeConstraints {
            $0.top.equalTo(platformNameLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(platformNameLabel.snp.height)
        }
        
        firstDividerView.snp.makeConstraints {
            $0.top.equalTo(classLabel.snp.bottom).offset(23)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(1)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(firstDividerView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(classLabel)
            $0.height.equalTo(16)
        }
        
        myAppNameLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(platformNameLabel.snp.height)
        }
        
        apiCreditLabel.snp.makeConstraints {
            $0.top.equalTo(myAppNameLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(appNameLabel.snp.height)
        }
        
        sofascoreLabel.snp.makeConstraints {
            $0.top.equalTo(apiCreditLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(platformNameLabel.snp.height)
        }
        
        developerLabel.snp.makeConstraints {
            $0.top.equalTo(sofascoreLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(appNameLabel.snp.height)
        }
        
        developerNameLabel.snp.makeConstraints {
            $0.top.equalTo(developerLabel.snp.bottom).offset(2)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(platformNameLabel.snp.height)
        }
        
        secondDividerView.snp.makeConstraints {
            $0.top.equalTo(developerNameLabel.snp.bottom).offset(23)
            $0.leading.trailing.equalTo(aboutLabel)
            $0.height.equalTo(firstDividerView.snp.height)
        }
        
        sofascoreImageView.snp.makeConstraints {
            $0.top.equalTo(secondDividerView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        logOutButton.snp.makeConstraints {
            $0.top.equalTo(sofascoreImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
    }
    
    @objc
    func buttonTapped() {
        buttonAction?()
    }
}


extension SettingsAboutView {
    
    @discardableResult
    func setButtonAction(_ closure: (() -> Void)?) -> Self {
        buttonAction = closure
        return self
    }
    
    @discardableResult
    func aboutLabelText(_ text: String) -> Self {
        aboutLabel.text = text
        return self
    }
    
    @discardableResult
    func platformNameText(_ text: String) -> Self {
        platformNameLabel.text = text
        return self
    }
    
    @discardableResult
    func classLabelText(_ text: String) -> Self {
        classLabel.text = text
        return self
    }
    
    @discardableResult
    func appNameLabelText(_ text: String) -> Self {
        appNameLabel.text = text
        return self
    }
    
    @discardableResult
    func myAppNameLabelText(_ text: String) -> Self {
        myAppNameLabel.text = text
        return self
    }
    
    @discardableResult
    func apiCreditLabelText(_ text: String) -> Self {
        apiCreditLabel.text = text
        return self
    }
    
    @discardableResult
    func sofascoreLabelText(_ text: String) -> Self {
        sofascoreLabel.text = text
        return self
    }
    
    @discardableResult
    func developerLabelText(_ text: String) -> Self {
        developerLabel.text = text
        return self
    }
    
    @discardableResult
    func developerNameLabelText(_ text: String) -> Self {
        developerNameLabel.text = text
        return self
    }
    
    @discardableResult
    func sofascoreImage(_ image: UIImage?) -> Self {
        sofascoreImageView.image = image
        return self
    }
}
