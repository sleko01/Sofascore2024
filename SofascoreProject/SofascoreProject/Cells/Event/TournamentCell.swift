//
//  TournamentCell.swift
//  SofascoreProject
//
//  Created by Sven Leko on 29.05.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

struct TournamentCellModel {
    
    var tournamentLogo: UIImage?
    let tournamentName: String
    let tournamentCountry: String
}

final class TournamentCell: UITableViewHeaderFooterView, BaseViewProtocol {
    static let identifier: String = .init(describing: TournamentCell.self)

    private let view: TournamentView = .init()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
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

    func model (_ model: TournamentCellModel) {
        view.holderRightPointerImage(.icPointerRight)
            .countryName(model.tournamentCountry)
            .tournamentName(model.tournamentName)
            .leagueLogo(model.tournamentLogo)
    }
}
