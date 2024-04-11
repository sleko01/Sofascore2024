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

class SettingsViewController: UIViewController, BaseViewProtocol {
    
    private let backButton: UIButton = .init()
    private let titleLabel: UILabel = .init()
    private var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        styleViews()
    }
    
    func addViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
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

    }
    
    func styleViews() {
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        titleLabel.text = "Settings"
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
