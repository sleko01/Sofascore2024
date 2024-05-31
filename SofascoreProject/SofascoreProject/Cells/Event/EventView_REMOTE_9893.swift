import Foundation
import SnapKit
import SofaAcademic
import UIKit

final class EventView: BaseView {

    private let matchTimeView: MatchTimeView = .init()
    private let homeTeamView: TeamView = .init()
    private let awayTeamView: TeamView = .init()
    private let homeTeamScoreLabel: UILabel = .init()
    private let awayTeamScoreLabel: UILabel = .init()
    private let dividerView: UIView = .init()

    override func addViews() {
        addSubview(matchTimeView)
        addSubview(dividerView)
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        addSubview(homeTeamScoreLabel)
        addSubview(awayTeamScoreLabel)
    }

    override func styleViews() {
        dividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        homeTeamScoreLabel.textAlignment = .right
        awayTeamScoreLabel.textAlignment = .right
        homeTeamScoreLabel.font = .body
        awayTeamScoreLabel.font = .body
    }

    override func setupConstraints() {
        matchTimeView.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.top.bottom.leading.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(matchTimeView.snp.trailing)
        }

        homeTeamView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(dividerView.snp.trailing).offset(16)
            $0.trailing.equalTo(homeTeamScoreLabel.snp.leading).offset(-8)
            $0.height.equalTo(16)
        }

        awayTeamView.snp.makeConstraints {
            $0.top.equalTo(homeTeamView.snp.bottom).offset(4)
            $0.leading.equalTo(homeTeamView.snp.leading)
            $0.trailing.equalTo(homeTeamView.snp.trailing)
            $0.height.equalTo(homeTeamView.snp.height)
        }

        homeTeamScoreLabel.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.top.bottom.equalTo(homeTeamView)
            $0.trailing.equalToSuperview().inset(16)
        }

        awayTeamScoreLabel.snp.makeConstraints {
            $0.width.equalTo(homeTeamScoreLabel.snp.width)
            $0.top.bottom.equalTo(awayTeamView)
            $0.trailing.equalTo(homeTeamScoreLabel.snp.trailing)
        }
    }
}

extension EventView {

    @discardableResult
    func matchStartTimeText(_ text: String) -> Self {
        matchTimeView.matchStartTime(text)
        return self
    }

    @discardableResult
    func matchStatusText(_ text: String) -> Self {
        matchTimeView.statusLabel(text)
        return self
    }

    @discardableResult
    func matchTimeColor(_ color: UIColor) -> Self {
        matchTimeView.currentMatchTimeColor(color)
        return self
    }

    @discardableResult
    func homeTeamLogo(_ image: UIImage?) -> Self {
        homeTeamView.teamLogo(image)
        return self
    }

    @discardableResult
    func homeTeamName(_ text: String) -> Self {
        homeTeamView.teamName(text)
        return self
    }

    @discardableResult
    func homeTeamNameColor(_ color: UIColor) -> Self {
        homeTeamView.teamNameColor(color)
        return self
    }

    @discardableResult
    func awayTeamLogo(_ image: UIImage?) -> Self {
        awayTeamView.teamLogo(image)
        return self
    }

    @discardableResult
    func awayTeamName(_ text: String) -> Self {
        awayTeamView.teamName(text)
        return self
    }

    @discardableResult
    func awayTeamNameColor(_ color: UIColor) -> Self {
        awayTeamView.teamNameColor(color)
        return self
    }

    @discardableResult
    func homeTeamScoreText(_ text: String) -> Self {
        homeTeamScoreLabel.text = text
        return self
    }

    @discardableResult
    func homeTeamScoreTextColor(_ color: UIColor) -> Self {
        homeTeamScoreLabel.textColor = color
        return self
    }

    @discardableResult
    func awayTeamScoreText(_ text: String) -> Self {
        awayTeamScoreLabel.text = text
        return self
    }

    @discardableResult
    func awayTeamScoreTextColor(_ color: UIColor) -> Self {
        awayTeamScoreLabel.textColor = color
        return self
    }
}
