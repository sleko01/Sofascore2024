import Foundation
import SnapKit
import SofaAcademic
import UIKit

struct EventCellModel {

    var homeTeamLogo: UIImage?
    let homeTeamName: String
    let homeTeamScoreText: String

    var awayTeamLogo: UIImage?
    let awayTeamName: String
    let awayTeamScoreText: String

    let matchStartTimeText: String
    let matchStatusText: String
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
        let isFullTime = model.matchStatusText == "FT"
        
        let homeTeamNameColor: UIColor = isFullTime && model.homeTeamScoreText <= model.awayTeamScoreText ? .onSurfaceOnSurfaceLv2 : .onSurfaceOnSurfaceLv1
        let awayTeamNameColor: UIColor
        let awayTeamScoreTextColor: UIColor
        
        if isFullTime {
            awayTeamNameColor = model.homeTeamScoreText < model.awayTeamScoreText ? .onSurfaceOnSurfaceLv1 : .onSurfaceOnSurfaceLv2
            awayTeamScoreTextColor = awayTeamNameColor
        } else {
            awayTeamNameColor = .onSurfaceOnSurfaceLv1
            awayTeamScoreTextColor = model.homeTeamScoreText <= model.awayTeamScoreText ? .onSurfaceOnSurfaceLv1 : .onSurfaceOnSurfaceLv2
        }
        
        view.homeTeamName(model.homeTeamName)
            .homeTeamNameColor(homeTeamNameColor)
            .homeTeamLogo(model.homeTeamLogo)
            .homeTeamScoreText(model.homeTeamScoreText)
            .homeTeamScoreTextColor(homeTeamNameColor)
            .awayTeamName(model.awayTeamName)
            .awayTeamNameColor(awayTeamNameColor)
            .awayTeamLogo(model.awayTeamLogo)
            .awayTeamScoreText(model.awayTeamScoreText)
            .awayTeamScoreTextColor(awayTeamScoreTextColor)
            .matchStatusText(model.matchStatusText)
            .matchStartTimeText(model.matchStartTimeText)
            .matchTimeColor(.onSurfaceOnSurfaceLv2)
    }

}
