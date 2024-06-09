//
//  SimpleTournamentCell.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

struct SimpleTournamentCellModel {
    let tournamentName: String
    let tournamentImage: UIImage?
}

final class SimpleTournamentCell: UICollectionViewCell, BaseViewProtocol {
    
    static let identifier: String = .init(describing: SimpleTournamentCell.self)
    private let view: SimpleTournamentView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(view)
    }

    func setupConstraints() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    func model(_ model: SimpleTournamentCellModel) {
        view
            .tournamentNameLabelText(model.tournamentName)
            .tournamentImage(model.tournamentImage)
    }

}
