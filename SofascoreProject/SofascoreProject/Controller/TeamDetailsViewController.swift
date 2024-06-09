//
//  TeamDetailsViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 09.06.2024..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamDetailsViewController: UIViewController, BaseViewProtocol {
    
    private let team: Team
    private let apiClient: ApiClient = .init()
    private let imageCache: ImageCache = .init()
    private let topSafeAreaBackgroundView: UIView = .init()
    private let headerView: TeamDetailsHeaderView = .init()
    private let tabBarView: TabBarView = .init()
    private var selectedTabIndex: Int = 0
    private var teamDetailsVC: DetailsTabViewController?
    private var eventsVC: EventsViewController?
    private let containerView: UIView = .init()
    private let detailsTab: TeamDetailsTabItemView = .init()
    private let matchesTab: TeamDetailsTabItemView = .init()

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
        view.backgroundColor = .surfaceSurface1
        addViews()
        styleViews()
        setupConstraints()
        setupViews()
        fetchTeamLogo(teamId: team.id.description)
        teamDetailsVC = DetailsTabViewController(team: team)
        if let teamDetailsVC = teamDetailsVC {
            add(teamDetailsVC, containerView: containerView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func addViews() {
        view.addSubview(topSafeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(tabBarView)
        view.addSubview(containerView)
    }
    
    func styleViews() {
        topSafeAreaBackgroundView.backgroundColor = .colorPrimaryDefault
        headerView.backgroundColor = .colorPrimaryDefault
        headerView.setButtonAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        tabBarView.backgroundColor = .colorPrimaryDefault
        detailsTab.tabNameLabelText(.details)
        matchesTab.tabNameLabelText(.matches)
        let tabs: [TabItemView] = [detailsTab, matchesTab]
        tabBarView
            .tabs(
                tabs,
                onIndexTapped: { [weak self] newIndex in
                    self?.onTabIndexTapped(newIndex)
                }
            )
            .selectedIndex(selectedTabIndex)

    }
    
    func setupConstraints() {
        topSafeAreaBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        tabBarView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(tabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupViews() {
        headerView
            .teamNameLabelText(team.name)
            .countryNameLabelText(team.country.name)
    }
    
    private func onTabIndexTapped(_ index: Int) {

        guard index != selectedTabIndex else {
            return
        }

        selectedTabIndex = index
        tabBarView.selectedIndex(selectedTabIndex)
        switchTab()
    }
    
    private func switchTab() {
        eventsVC?.remove()
        teamDetailsVC?.remove()
        eventsVC = nil
        teamDetailsVC = nil
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        if (selectedTabIndex == 0) {
            teamDetailsVC = DetailsTabViewController(team: team)
            if let teamDetailsVC = teamDetailsVC {
                add(teamDetailsVC, containerView: containerView)
            }
            teamDetailsVC?.view.layer.add(animation, forKey: "viewControllerTransition")
        } else {
            eventsVC = EventsViewController(team: team, onlyOne: false)
            if let eventsVC = eventsVC {
                add(eventsVC, containerView: containerView)
            }
            eventsVC?.view.layer.add(animation, forKey: "viewControllerTransition")
        }
        
    }
}

extension TeamDetailsViewController {
    
    private func fetchTeamLogo(teamId: String) {
        if let cachedImage = imageCache.getImage(forKey: "team." + teamId) {
            headerView.teamLogoImage(cachedImage)
        } else {
            apiClient.fetchTeamLogo(teamId: teamId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.imageCache.setImage(image, forKey: "team." + teamId)
                    DispatchQueue.main.async {
                        self.headerView.teamLogoImage(image)
                    }
                case .failure:
                    return
                }
            }
        }
    }
}
