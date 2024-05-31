//
//  TabView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 10.04.2024..
//

import Foundation
import SofaAcademic
import UIKit

class TabView: UIStackView, BaseViewProtocol {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupTabView()
    }
    
    
    func addViews() {
        
    }
    
    func setupConstraints() {

    }
    
    private func setupTabView() {
        axis = .horizontal
        distribution = .fillEqually
        backgroundColor = .blue
    }
    
}
