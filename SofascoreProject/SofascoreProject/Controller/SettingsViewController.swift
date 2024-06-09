//
//  SettingsViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit
import KeychainAccess

class SettingsViewController: UIViewController, BaseViewProtocol {
    
    private let backButton: UIButton = .init()
    private let titleLabel: UILabel = .init()
    private var buttonAction: (() -> Void)?
    private let keychain: Keychain = .init()
    private let settingsAboutView: SettingsAboutView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfaceSurface1
        addViews()
        setupConstraints()
        styleViews()
    }
    
    func addViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(settingsAboutView)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        settingsAboutView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

    }
    
    func styleViews() {
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        titleLabel.text = "Settings"
        settingsAboutView
            .setButtonAction {
                self.keychain["sofascore"] = nil
                self.dismiss(animated: true)
            }
            .aboutLabelText("About")
            .platformNameText("Sofascore 2024 Academy")
            .classLabelText("Class 2024")
            .appNameLabelText("App Name")
            .myAppNameLabelText("Sofascore Clone 2024")
            .apiCreditLabelText("API Credit")
            .sofascoreLabelText("Sofascore")
            .developerLabelText("Developer")
            .developerNameLabelText("Sven Leko")
            .sofascoreImage(UIImage(resource: .sofascoreBlue))
    }
    
    @objc
    func buttonTapped() {
        buttonAction?()
    }
}

extension SettingsViewController {
    
    @discardableResult
    func setButtonAction(_ closure: (() -> Void)?) -> Self {
        buttonAction = closure
        return self
    }
}
