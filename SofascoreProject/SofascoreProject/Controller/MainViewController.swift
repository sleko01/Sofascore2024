//  MainViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit
import KeychainAccess

enum Helper {

    static let preferredSportKey: String = "preferred_sport"
    
    static var preferredSport: SportType {
        get {
            guard let value: String = UserDefaults.standard.string(forKey: preferredSportKey) else {
                return .football
            }

            return SportType(rawValue: value) ?? .football
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: preferredSportKey)
        }
    }
}

class MainViewController: UIViewController, BaseViewProtocol {
    
    private let topSafeAreaBackgroundView: UIView = .init()
    private let headerView: HeaderView = .init()
    private let tabBarView: TabBarView = .init()

    private var availableSports: [SportType] = SportType.allCases
    private var selectedSport: SportType = Helper.preferredSport
    private var selectedSportIndex: Int {
        availableSports.firstIndex(of: selectedSport) ?? 0
    }
    
    private let dayAndEventNumberView: DayAndEventNumberView = .init()
    
    private var selectedDate: Date = Date()

    private let containerView: UIView = .init()
    private var eventsVC: EventsViewController?
    
    private let calendarVC: CalendarViewController = .init()
    private let calendarContainer: UIView = .init()
    private let keychain:Keychain = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .surfaceSurface1
        addViews()
        setupConstraints()
        styleViews()
        eventsVC = EventsViewController(sport: selectedSport, date: selectedDate)
        eventsVC?.updateEventNumber { [weak self] eventNumber in
            self?.dayAndEventNumberView.eventNumberLabelText(eventNumber.description + " Events")
        }
        if let eventsVC = eventsVC {
            add(eventsVC, containerView: containerView)
        }
        add(calendarVC, containerView: calendarContainer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let token = keychain["sofascore"]
        if (token != "token") {
            let loginViewController: LoginViewController = .init()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: false)
        }
        navigationController?.navigationBar.isHidden = true
    }
    
    func addViews() {
        view.addSubview(topSafeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(tabBarView)
        view.addSubview(calendarContainer)
        view.addSubview(containerView)
        view.addSubview(dayAndEventNumberView)
    }
    
    func setupConstraints() {
        topSafeAreaBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        tabBarView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview()
        }
        
        calendarContainer.snp.makeConstraints {
            $0.top.equalTo(tabBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        dayAndEventNumberView.snp.makeConstraints {
            $0.top.equalTo(calendarContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(dayAndEventNumberView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func styleViews() {
        topSafeAreaBackgroundView.backgroundColor = .colorPrimaryDefault
        
        headerView.backgroundColor = .colorPrimaryDefault
        headerView.appLogoImage(.sofascoreLockup)
        headerView.trophyIconImage(.trophy)
        headerView.settingsButtonImage(.options)

        headerView.setButtonAction {
            let settingsVC: SettingsViewController = .init()
            settingsVC.modalPresentationStyle = .fullScreen
            self.present(settingsVC, animated: true)
            settingsVC.setButtonAction {
                settingsVC.dismiss(animated: true)
            }
        }
        
        tabBarView.backgroundColor = .colorPrimaryDefault

        let tabs: [TabItemView] = availableSports.map { sport in
            TabItemView()
                .sportsIcon(sport.icon)
                .sportName(sport.rawValue)
        }

        tabBarView
            .tabs(
                tabs,
                onIndexTapped: { [weak self] newIndex in
                    self?.onTabIndexTapped(newIndex)
                }
            )
            .selectedIndex(selectedSportIndex)
        
        calendarVC.onClickAction { [weak self] selectedDate in
            self?.onChangedDate(selectedDate)
        }
        
        dayAndEventNumberView.dayLabelText(DateFormatter.dateToDateLabel(date: selectedDate))
        dayAndEventNumberView.backgroundColor = .surfaceSurface0
        eventsVC?.updateEventNumber { [weak self] eventNumber in
            self?.dayAndEventNumberView.eventNumberLabelText(eventNumber.description + " Events")
        }
    }
    
    private func onTabIndexTapped(_ index: Int) {
        guard availableSports.indices.contains(index) else {
            return
        }

        let newSport: SportType = availableSports[index]

        guard selectedSport != newSport else {
            return
        }

        selectedSport = newSport
        Helper.preferredSport = newSport
        tabBarView.selectedIndex(selectedSportIndex)
        switchSport()
    }
    
    private func onChangedDate(_ date: Date) {
        guard selectedDate != date else {
            return
        }
        
        selectedDate = date
        dayAndEventNumberView.dayLabelText(DateFormatter.dateToDateLabel(date: selectedDate))
        switchSport()
    }

    private func switchSport() {
        eventsVC?.remove()
        eventsVC = nil
        eventsVC = EventsViewController(sport: selectedSport, date: selectedDate)
        eventsVC?.updateEventNumber { [weak self] eventNumber in
            self?.dayAndEventNumberView.eventNumberLabelText(eventNumber.description + " Events")
        }
        if let eventsVC = eventsVC {
            add(eventsVC, containerView: containerView)
        }
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        eventsVC?.view.layer.add(animation, forKey: "viewControllerTransition")
    }
}
