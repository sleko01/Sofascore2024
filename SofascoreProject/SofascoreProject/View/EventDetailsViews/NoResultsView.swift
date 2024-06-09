//
//  NoResultsView.swift
//  SofascoreProject
//
//  Created by Sven Leko on 04.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class NoResultsView: BaseView {
    
    private let noResultsLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(noResultsLabel)
    }
    
    override func styleViews() {
        noResultsLabel.text = "No results yet."
        noResultsLabel.textAlignment = .center
        noResultsLabel.font = .bodyParagraph
        noResultsLabel.textColor = .onSurfaceOnSurfaceLv2
    }
    
    override func setupConstraints() {
        noResultsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
    }
}

extension NoResultsView {
    
    @discardableResult
    func noResultsLabelText(_ text: String) -> Self {
        noResultsLabel.text = text
        return self
    }
}
