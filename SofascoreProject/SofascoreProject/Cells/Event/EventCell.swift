import Foundation
import SnapKit
import SofaAcademic
import UIKit

struct EventCellModel {

    let homeTeamLogo: UIImage?
    let homeTeamName: String
    let homeTeamNameColor: UIColor
    let homeTeamScoreText: String
    let homeTeamScoreTextColor: UIColor

    let awayTeamLogo: UIImage?
    let awayTeamName: String
    let awayTeamNameColor: UIColor
    let awayTeamScoreText: String
    let awayTeamScoreTextColor: UIColor

    let matchStartTimeText: String
    let matchStatusText: String
    let matchTimeColor: UIColor
}

final class EventCell: UITableViewCell, BaseViewProtocol {

    static let identifier: String = .init(describing: EventCell.self)

    private let view: EventView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    func model(_ model: EventCellModel) {
        view.homeTeamName(model.homeTeamName)
            .homeTeamNameColor(model.homeTeamNameColor)
            .homeTeamLogo(model.homeTeamLogo)
            .homeTeamScoreText(model.homeTeamScoreText)
            .homeTeamScoreTextColor(model.homeTeamScoreTextColor)
            .awayTeamName(model.awayTeamName)
            .awayTeamNameColor(model.awayTeamNameColor)
            .awayTeamLogo(model.awayTeamLogo)
            .awayTeamScoreText(model.awayTeamScoreText)
            .awayTeamScoreTextColor(model.awayTeamScoreTextColor)
            .matchStatusText(model.matchStatusText)
            .matchStartTimeText(model.matchStartTimeText)
            .matchTimeColor(model.matchTimeColor)
    }
}
