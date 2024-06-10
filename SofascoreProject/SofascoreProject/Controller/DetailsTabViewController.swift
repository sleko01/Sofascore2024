//
//  DetailsTabViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

struct SimpleTournament {
    let name: String
    let logo: UIImage?
}

class DetailsTabViewController: UIViewController, BaseViewProtocol {
    
    private let team: Team
    private let teamInfoView: InfoView = .init()
    private let coachView: CoachView = .init()
    private let horizontalStackView: UIStackView = .init()
    private let totalPlayersInfoView: AdditionalTeamInfoView = .init()
    private let foreignPlayersInfoView: AdditionalTeamInfoView = .init()
    private let tournamentsInfoView: InfoView = .init()
    private let tournamentsStackView: UIStackView = .init()
    private let venueInfoView: InfoView = .init()
    private let venueView: VenueView = .init()
    private let nextMatchInfoView: InfoView = .init()
    private let containerView: UIView = .init()
    private let firstDividerView: UIView = .init()
    private let secondDividerView: UIView = .init()
    private let thirdDividerView: UIView = .init()
    private let fourthDividerView: UIView = .init()
    private let apiClient: ApiClient = .init()
    private var players: [Player] = []
    private var teamTournaments: [Tournament] = []
    private var simpleTournaments: [SimpleTournament] = []
    private var eventsVC: EventsViewController?
    
    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        
        fetchTeamDetails()
        fetchPlayers()
        eventsVC = EventsViewController(team: team, onlyOne: true)
        eventsVC?.getTableView().isScrollEnabled = false
        if let eventsVC = eventsVC {
            add(eventsVC, containerView: containerView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTournaments()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func updateTournaments() {
        apiClient.getTeamTournamentsByTeamid(teamId: team.id.description) { result in
            switch result {
            case .success(let tournaments):
                self.teamTournaments = tournaments
                self.fetchTournamentLogos()
            case .failure(let error):
                print("Error fetching tournaments: \(error)")
            }
        }
    }
    
    private func fetchTournamentLogos() {
        simpleTournaments.removeAll()
        
        let group = DispatchGroup()
        
        for tournament in teamTournaments {
            group.enter()
            
            apiClient.fetchTournamentLogo(tournamentId: tournament.id.description) { result in
                switch result {
                case .success(let image):
                    self.simpleTournaments.append(SimpleTournament(name: tournament.name, logo: image))
                case .failure(let error):
                    print("Failed to fetch logo for tournament \(tournament.name): \(error)")
                    self.simpleTournaments.append(SimpleTournament(name: tournament.name, logo: nil))
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.updateTournamentUI()
        }
    }
    
    func updateTournamentUI() {
        tournamentsStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for simpleTournament in simpleTournaments {
            let tournamentView = SimpleTournamentView()
                .tournamentNameLabelText(simpleTournament.name)
                .tournamentImage(simpleTournament.logo)
            
            tournamentsStackView.addArrangedSubview(tournamentView)
        }
    }
    
    func addViews() {
        view.addSubview(teamInfoView)
        view.addSubview(coachView)
        view.addSubview(firstDividerView)
        view.addSubview(horizontalStackView)
        view.addSubview(secondDividerView)
        view.addSubview(tournamentsInfoView)
        view.addSubview(tournamentsStackView)
        view.addSubview(thirdDividerView)
        view.addSubview(venueInfoView)
        view.addSubview(venueView)
        view.addSubview(fourthDividerView)
        view.addSubview(nextMatchInfoView)
        view.addSubview(containerView)
        horizontalStackView.addArrangedSubview(totalPlayersInfoView)
        horizontalStackView.addArrangedSubview(foreignPlayersInfoView)
    }
    
    func styleViews() {
        teamInfoView.infoLabelText("Team Info")
        venueInfoView.infoLabelText("Venue")
        nextMatchInfoView.infoLabelText("Next Match")
        tournamentsInfoView.infoLabelText("Tournaments")
        totalPlayersInfoView.infoDescriptionLabelText("Total Players")
        foreignPlayersInfoView.infoDescriptionLabelText("Foreign Players")
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        
        tournamentsStackView.axis = .horizontal
        tournamentsStackView.distribution = .equalCentering
        
        firstDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        secondDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        thirdDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        fourthDividerView.backgroundColor = .onSurfaceOnSurfaceLv4
        totalPlayersInfoView.infoImage(.icTeam)
        foreignPlayersInfoView.infoImage(.round)
    }
    
    func setupConstraints() {
        teamInfoView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        coachView.snp.makeConstraints {
            $0.top.equalTo(teamInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        firstDividerView.snp.makeConstraints {
            $0.top.equalTo(coachView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(firstDividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(116)
        }
        
        secondDividerView.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom).inset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        tournamentsInfoView.snp.makeConstraints {
            $0.top.equalTo(secondDividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        tournamentsStackView.snp.makeConstraints {
            $0.top.equalTo(tournamentsInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(96)
        }
        
        thirdDividerView.snp.makeConstraints {
            $0.top.equalTo(tournamentsStackView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        venueInfoView.snp.makeConstraints {
            $0.top.equalTo(thirdDividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        venueView.snp.makeConstraints {
            $0.top.equalTo(venueInfoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        fourthDividerView.snp.makeConstraints {
            $0.top.equalTo(venueView.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        nextMatchInfoView.snp.makeConstraints {
            $0.top.equalTo(fourthDividerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(nextMatchInfoView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func fetchTeamDetails() {
        apiClient.getTeamInfoByTeamId(teamId: team.id.description) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let team):
                    self.updateUI(with: team)
                case .failure(let error):
                    print("Failed to get team details: \(error)")
                }
            }
        }
    }
    
    private func updateUI(with team: Team) {
        DispatchQueue.main.async {
            self.coachView.coachNameLabelText("Coach: " + (team.managerName ?? ""))
            self.totalPlayersInfoView.infoNumberLabelText(self.players.count.description)
            self.venueView.stadiumNameLabelText(team.venue ?? "")
        }
    }
    
    private func fetchPlayers() {
        apiClient.getPlayersFromTeamByTeamId(teamId: team.id.description) { [weak self] result in
            switch result {
            case .success(let players):
                self?.players = players
                DispatchQueue.main.async {
                    self?.totalPlayersInfoView.infoNumberLabelText(players.count.description)
                    self?.updateForeignPlayersInfo()
                }
            case .failure(let error):
                print("Failed to get players: \(error)")
            }
        }
    }
    
    private func updateForeignPlayersInfo() {
        let foreignPlayersCount = players.filter { $0.country.id != team.country.id }.count
        DispatchQueue.main.async {
            self.foreignPlayersInfoView.infoNumberLabelText(foreignPlayersCount.description)
        }
    }
}
