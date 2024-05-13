//
//  EventsViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 25.03.2024..
//

import Foundation
import UIKit
import SnapKit

class EventsViewController: UIViewController {
    
    private let tableView: UITableView = .init()
    private var matchList: [Match] = []
    private let sport: SportType
    
    init(sport: SportType) {
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 56

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // mock data setup
        let barcelona: Team = .init(name: "Barcelona", logo: .barcelona)
        let manUtd: Team = .init(name: "Manchester United", logo: .manUtd)

        let match1: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710676800, matchStatus: .finished, homeTeamScore: 1, awayTeamScore: 2)
        let match2: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710687600, matchStatus: .inProgress, homeTeamScore: 0, awayTeamScore: 1)
        let match3: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710694800, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match4: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710700200, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match5: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710676800, matchStatus: .finished, homeTeamScore: 1, awayTeamScore: 2)
        let match6: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710687600, matchStatus: .inProgress, homeTeamScore: 0, awayTeamScore: 1)
        let match7: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710694800, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match8: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710700200, matchStatus: .notStarted, homeTeamScore: nil, awayTeamScore: nil)
        let match9: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710686800, matchStatus: .finished, homeTeamScore: 1, awayTeamScore: 2)
        let match10: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710767600, matchStatus: .inProgress, homeTeamScore: 0, awayTeamScore: 1)
        let match11: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1712394800, matchStatus: .inProgress, homeTeamScore: 1, awayTeamScore: 2)
        let match12: Match = Match(homeTeam: manUtd, awayTeam: barcelona, startTime: 1710340200, matchStatus: .finished, homeTeamScore: 4, awayTeamScore: 3)
        
        matchList = [match1, match2, match3, match4, match5, match6, match7, match8, match9, match10, match11, match12]
    }
}

extension EventsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }

        let match: Match = matchList[indexPath.row]
        
        let model: EventCellModel = .init(
            homeTeamLogo: match.homeTeam.logo,
            homeTeamName: match.homeTeam.name,
            homeTeamNameColor: .gray,
            homeTeamScoreText: "2",
            homeTeamScoreTextColor: .gray,
            awayTeamLogo: match.awayTeam.logo,
            awayTeamName: match.awayTeam.name,
            awayTeamNameColor: .gray,
            awayTeamScoreText: "1",
            awayTeamScoreTextColor: .red,
            matchStartTimeText: match.startTimeFormatted,
            matchStatusText: "FT",
            matchTimeColor: .red
        )

        cell.model(model)
        return cell
    }
}


extension EventsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailsVC = EventDetailsViewController(eventId: indexPath.row)
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}
