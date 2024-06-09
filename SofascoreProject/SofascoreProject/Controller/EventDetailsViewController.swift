//
//  EventDetailsViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.04.2024..
//

import Foundation
import SofaAcademic
import UIKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    
    private let eventId: Int
    private var match: Match?
    private let apiClient: ApiClient = .init()
    private let imageCache: ImageCache = .init()
    private let refreshControl: UIRefreshControl = .init()
    private var autoRefreshTimer: Timer?
    private let navigationHeaderView: NavigationHeaderView = .init()
    private let horizontalStackView: UIStackView = .init()
    private let homeTeamDataView: TeamDataView = .init()
    private let awayTeamDataView: TeamDataView = .init()
    private let matchStatusView: UIView = .init()
    private var eventIncidentsViewController: EventIncidentsViewController?
    private let eventIncidentsContainerView: UIView = .init()
    private let horizontalDividerView: UIView = .init()
    
    init(eventId: Int) {
        self.eventId = eventId
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfaceSurface1
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
        startTimer()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let match = match else {
            return
        }
        
        eventIncidentsViewController = EventIncidentsViewController(eventId: eventId, match: match)
        if let eventIncidentsVC = eventIncidentsViewController {
            add(eventIncidentsVC, containerView: eventIncidentsContainerView)
        }
        
        let descriptionText = "\(match.tournament.sport.name), \(match.tournament.country.name), \(match.tournament.name), Round \(match.round)"
        navigationHeaderView.descriptionLabelText(descriptionText)
        
        fetchTournamentLogo(tournamentId: match.tournament.id.description) { image in
            DispatchQueue.main.async {
                self.navigationHeaderView.tournamentImage(image)
            }
        }
        
        fetchTeamLogo(teamId: match.homeTeam.id.description) { image in
            DispatchQueue.main.async {
                self.homeTeamDataView
                    .teamNameLabelText(match.homeTeam.name)
                    .teamLogoImage(image)
            }
        }

        fetchTeamLogo(teamId: match.awayTeam.id.description) { image in
            DispatchQueue.main.async {
                self.awayTeamDataView
                    .teamNameLabelText(match.awayTeam.name)
                    .teamLogoImage(image)
            }
        }
        
        switch match.status {
            case MatchStatus.notStarted.rawValue:
            let upcomingEventView: UpcomingEventView = .init()
               upcomingEventView
                   .dateLabelText(DateFormatter.dateStringToDayMonthYear(date: match.startDate))
                   .matchStartTimeLabelText(DateFormatter.dateStringToHourMinutes(date: match.startDate))

               matchStatusView.addSubview(upcomingEventView)
               
               upcomingEventView.snp.makeConstraints { make in
                   make.edges.equalToSuperview()
               }
                
            case MatchStatus.inProgress.rawValue, MatchStatus.finished.rawValue:
            let inProgressOrFinishedEventView: InProgressOrFinishedEventView = .init()
            guard let homeScore = match.homeScore.total, let awayScore = match.awayScore.total else {
                return
            }
            inProgressOrFinishedEventView
                .homeTeamScoreLabelText(homeScore.description)
                .homeTeamScoreLabelTextColor(match.status == MatchStatus.inProgress.rawValue ? .specificLive : (homeScore > awayScore ? .onSurfaceOnSurfaceLv1 : .onSurfaceOnSurfaceLv2))
                .awayTeamScoreLabelText(awayScore.description)
                .awayTeamScoreLabelTextColor(match.status == MatchStatus.inProgress.rawValue ? .specificLive : (awayScore > homeScore ? .onSurfaceOnSurfaceLv1 : .onSurfaceOnSurfaceLv2))
                .matchProgressLabelText(match.status == MatchStatus.inProgress.rawValue ? match.status : .fulltime)
                .matchProgressLabelTextColor(match.status == MatchStatus.inProgress.rawValue ? .specificLive : .onSurfaceOnSurfaceLv2)
            
            matchStatusView.addSubview(inProgressOrFinishedEventView)
            inProgressOrFinishedEventView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            default:
                break
            }
            
            matchStatusView.layoutIfNeeded()
    }
    
    func addViews() {
        view.addSubview(navigationHeaderView)
        view.addSubview(horizontalStackView)
        view.addSubview(horizontalDividerView)
        view.addSubview(eventIncidentsContainerView)
    }
    
    func setupConstraints() {
        navigationHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(navigationHeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        
        horizontalDividerView.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        eventIncidentsContainerView.snp.makeConstraints {
            $0.top.equalTo(horizontalDividerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func styleViews() {
        navigationHeaderView.setButtonAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalCentering
        horizontalStackView.addArrangedSubview(homeTeamDataView)
        horizontalStackView.addArrangedSubview(matchStatusView)
        horizontalStackView.addArrangedSubview(awayTeamDataView)
        
        matchStatusView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(136)
        }
        
        horizontalDividerView.backgroundColor = .surfaceSurface0
    }
    
    func setupBinding() {
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeTeamTapped))
        homeTeamDataView.addGestureRecognizer(homeTapGesture)
        homeTeamDataView.isUserInteractionEnabled = true

        let awayTapGesture = UITapGestureRecognizer(target: self, action: #selector(awayTeamTapped))
        awayTeamDataView.addGestureRecognizer(awayTapGesture)
        awayTeamDataView.isUserInteractionEnabled = true
    }
    
    @objc
    private func refreshData() {
        apiClient.getEventByEventId(eventId: eventId.description) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let match):
                    self.match = match
                    self.view.setNeedsLayout()
                case .failure(let error):
                    print("Failed to get event: \(error)")
                }
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc private func homeTeamTapped() {
            guard let match = match else { return }
            let teamDetailsVC = TeamDetailsViewController(team: match.homeTeam)
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }

        @objc private func awayTeamTapped() {
            guard let match = match else { return }
            let teamDetailsVC = TeamDetailsViewController(team: match.awayTeam)
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }

    
    private func startTimer() {
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] timer in
            self?.refreshData()
        }
    }
}

extension EventDetailsViewController {
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
                    return
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
                    return
                }
            }
        }
    }
}
