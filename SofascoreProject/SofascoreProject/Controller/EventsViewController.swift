import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EventsViewController: UIViewController, BaseViewProtocol {
    
    private let tableView: UITableView = .init()
    private let noEventsView: NoEventsView = .init()
    private let apiClient: ApiClient = .init()
    private var matchList: [Match] = []
    private let sport: SportType
    private let date: Date
    private var tournaments: [Tournament] = []
    private let imageCache: ImageCache = .init()
    private var updateEventNumber: ((_ eventNumber: Int) -> Void)?
    private let refreshControl:UIRefreshControl = .init()
    private var autoRefreshTimer: Timer?
    
    init(sport: SportType, date: Date) {
        self.sport = sport
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfaceSurface1
        noEventsView
            .warningTextLabelText("No events!")
            .warningImageViewImage(.exclamation)
            .isHidden = true
        setupTableView()
        addViews()
        setupConstraints()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        startTimer()
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = nil
    }
    
    func addViews() {
        view.addSubview(tableView)
        view.addSubview(noEventsView)
    }
    
    func setupConstraints() {
        noEventsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        tableView.register(TournamentCell.self, forHeaderFooterViewReuseIdentifier: TournamentCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 56
        tableView.sectionHeaderTopPadding = 0.0
        tableView.addSubview(refreshControl)
    }
    
    @objc
    private func refreshData() {
        apiClient.getAllEvents(sport: sport, date: date) { tournaments, error in
            self.tournaments = tournaments
            let sum = tournaments.reduce(0) { $0 + $1.matchList.count }
            self.updateEventNumber?(sum)
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func startTimer() {
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] timer in
            self?.refreshData()
        }
    }

}

extension EventsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        updateNoEventsView()
        return tournaments.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !tournaments.isEmpty else {
            return 0
        }
        return tournaments[section].matchList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UITableViewCell()
        }

        guard !tournaments.isEmpty, !tournaments[indexPath.section].matchList.isEmpty else {
            return UITableViewCell()
        }

        let match = tournaments[indexPath.section].matchList[indexPath.row]

        var model = EventCellModel(
            homeTeamName: match.homeTeam.name,
            homeTeamScoreText: match.homeScore.total?.description ?? "",
            awayTeamName: match.awayTeam.name,
            awayTeamScoreText: match.awayScore.total?.description ?? "",
            matchStartTimeText: DateFormatter.formatTimeInterval(startTime: match.startDate),
            matchStatusText: match.status == "finished" ? "FT" : "-"
        )
            
        cell.model(model)
        
        fetchTeamLogo(teamId: match.homeTeam.id.description) { image in
            DispatchQueue.main.async {
                model.homeTeamLogo = image
                cell.model(model)
            }
        }

        fetchTeamLogo(teamId: match.awayTeam.id.description) { image in
            DispatchQueue.main.async {
                model.awayTeamLogo = image
                cell.model(model)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TournamentCell.identifier) as? TournamentCell else {
            return UITableViewHeaderFooterView()
        }
        
        let tournament = tournaments[section]
        
        var model = TournamentCellModel(
            tournamentName: tournament.name,
            tournamentCountry: tournament.country.name
        )
        
        headerView.model(model)
        fetchTournamentLogo(tournamentId: tournament.id.description) { image in
            DispatchQueue.main.async {
                model.tournamentLogo = image
                headerView.model(model)
            }
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailsVC = EventDetailsViewController(eventId: tournaments[indexPath.section].matchList[indexPath.row].id)
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}

extension EventsViewController {
    
    private func fetchTeamLogo(teamId: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.getImage(forKey: "team." + teamId) {
            completion(cachedImage)
        } else {
            apiClient.fetchTeamLogo(teamId: teamId) { result in
                switch result {
                case .success(let image):
                    self.imageCache.setImage(image, forKey: "team." + teamId)
                    completion(image)
                case .failure:
                    completion(self.sport.icon)
                }
            }
        }
    }

    private func fetchTournamentLogo(tournamentId: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.getImage(forKey: "tournament." + tournamentId) {
            completion(cachedImage)
        } else {
            apiClient.fetchTournamentLogo(tournamentId: tournamentId) { result in
                switch result {
                case .success(let image):
                    self.imageCache.setImage(image, forKey: "tournament." + tournamentId)
                    completion(image)
                case .failure:
                    completion(self.sport.icon)
                }
            }
        }
    }
    
    private func updateNoEventsView() {
        if tournaments.isEmpty {
            noEventsView.isHidden = false
        } else {
            noEventsView.isHidden = true
        }
    }

}

extension EventsViewController {
    
    @discardableResult
    func updateEventNumber(_ closure: ((_ eventNumber: Int) -> Void)?) -> Self {
        updateEventNumber = closure
        return self
    }
}
