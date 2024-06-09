//
//  EventIncidentsViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 04.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EventIncidentsViewController: UIViewController, BaseViewProtocol {

    private let apiClient: ApiClient = .init()
    private let eventId: Int
    private let match: Match
    private var incidents: [Incident] = []
    private let refreshControl: UIRefreshControl = .init()
    private let noResultsYetView: NoResultsView = .init()
    private let incidentsTableView: UITableView = .init()
    private var autoRefreshTimer: Timer?
    
    init(eventId: Int, match: Match) {
        self.eventId = eventId
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print(eventId)
        super.viewDidLoad()
        view.backgroundColor = .surfaceSurface0
        noResultsYetView.isHidden = true
        addViews()
        setupConstraints()
        styleViews()
        setupTableView()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        startTimer()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = incidentsTableView.indexPathForSelectedRow {
            incidentsTableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = nil
    }

    func addViews() {
        view.addSubview(noResultsYetView)
        view.addSubview(incidentsTableView)
    }
    
    func setupConstraints() {
        noResultsYetView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(52)
        }
        
        incidentsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func styleViews() {
        noResultsYetView.backgroundColor = .surfaceSurface2
        noResultsYetView.layer.cornerRadius = 8.0
        noResultsYetView.noResultsLabelText(.noResultsYet)
    }

    @objc
    private func refreshData() {
        apiClient.fetchEventIncidentsByEventId(eventId: eventId.description) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let incidents):
                    self.incidents = incidents
                    self.updateNoResultsView()
                    self.incidentsTableView.reloadData()
                case .failure(let error):
                    print("Failed to get event: \(error)")
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func startTimer() {
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] timer in
            self?.refreshData()
        }
    }
    
    private func updateNoResultsView() {
        noResultsYetView.isHidden = !incidents.isEmpty
        incidentsTableView.isHidden = incidents.isEmpty
    }
    
    private func setupTableView() {
        incidentsTableView.dataSource = self
        incidentsTableView.delegate = self
        incidentsTableView.register(EventIncidentCell.self, forCellReuseIdentifier: EventIncidentCell.identifier)
        incidentsTableView.register(EventIncidentHeaderCell.self, forHeaderFooterViewReuseIdentifier: EventIncidentHeaderCell.identifier)
        incidentsTableView.separatorStyle = .none
        incidentsTableView.rowHeight = 56
        incidentsTableView.sectionHeaderTopPadding = 0.0
        incidentsTableView.addSubview(refreshControl)
        incidentsTableView.allowsSelection = false
    }
}

extension EventIncidentsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return incidents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents[section].subIncidents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventIncidentCell.identifier, for: indexPath) as? EventIncidentCell else {
            return UITableViewCell()
        }

        guard !incidents.isEmpty, let subIncidents = incidents[indexPath.section].subIncidents else {
            return UITableViewCell()
        }
        
        let incident = subIncidents[indexPath.row]
        let side: String? = incident.teamSide ?? incident.scoringTeam
        var image = ""
        if let color = incident.color, let type = incident.type {
            image = color + type != "yellowredcard" ? color + type : "redcard"
        } else {
            image = incident.type ?? ""
        }
        let model = EventIncidentCellModel(
            incidentImage: image,
            timeOfIncident: incident.time ?? 0,
            playerName: incident.player?.name ?? "No player data",
            incidentDescription: incident.type != IncidentType.goal.rawValue ? .foul : nil,
            homeScore: incident.homeScore,
            awayScore: incident.awayScore,
            teamSide: side ?? "home",
            type: IncidentType(rawValue: IncidentType.RawValue(incident.type ?? "period")) ?? .period
        )
        
        cell.model(model)
        return cell
    }
}

extension EventIncidentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: EventIncidentHeaderCell.identifier) as? EventIncidentHeaderCell else {
            return UITableViewHeaderFooterView()
        }
        
        let period = incidents[section]
        
        let model = EventIncidentHeaderModel(
            incidentHeaderLabelText: period.text ?? "",
            status: MatchStatus(rawValue: match.status) == .finished ? .finished : .inProgress
        )
        
        headerView.model(model)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
