//
//  MainViewController.swift
//  SofascoreProject
//
//  Created by Sven Leko on 08.04.2024..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController, BaseViewProtocol {
    
    static var appLogoName: String = "sofascore_lockup"
    static var settingsIconName: String = "Icon 1"
    static var trophyIconName: String = "Icon 2"  // could be moved somewhere else
    private let topSafeAreaBackgroundView: UIView = .init()
    private let headerView: HeaderView = .init()
    private let tabView: UIStackView = .init()
    private let containerView: UIView = .init()
    private var eventsVC: EventsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "Preferred sport") == nil {
            UserDefaults.standard.set("Football", forKey: "Preferred sport")
        }
        view.backgroundColor = .white
        addViews()
        setupConstraints()
        styleViews()
        eventsVC = EventsViewController(sport: SportType(rawValue: UserDefaults.standard.object(forKey: "Preferred sport") as! String)!)
        add(eventsVC!, containerView: containerView) // adding a child to MainVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func addViews() {
        view.addSubview(topSafeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(tabView)
        view.addSubview(containerView)
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
        
        tabView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(tabView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func styleViews() {
        topSafeAreaBackgroundView.backgroundColor = .blue
        
        headerView.backgroundColor = .blue
        headerView.appLogoImageName(MainViewController.appLogoName)
        headerView.trophyIconImageName(MainViewController.trophyIconName)
        headerView.settingsButtonImageName(MainViewController.settingsIconName)
        
        headerView.setButtonAction {
            let settingsVC: SettingsViewController = .init()
            settingsVC.modalPresentationStyle = .fullScreen
            self.present(settingsVC, animated: true)
            settingsVC.setButtonAction {
                settingsVC.dismiss(animated: true)
            }
        }
        
        tabView.axis = .horizontal
        tabView.distribution = .fillEqually
        tabView.backgroundColor = .blue
        for sport in SportType.allCases {
            let tabItem: TabItemView = .init()
            tabItem.sportsIcon(sport.rawValue)
            tabItem.sportName(sport.rawValue)
            tabItem.isSportSelected(sport.rawValue == UserDefaults.standard.object(forKey: "Preferred sport") as! String)
            tabItem.setTapHandleAction {
                self.changeSelectedLabel(tabView: self.tabView, selectedLabel: sport.rawValue)
            }
            tabView.addArrangedSubview(tabItem)
        }
    }
    
    @discardableResult
    private func changeSelectedLabel(tabView: UIStackView, selectedLabel: String) -> Self {
        UserDefaults.standard.set(selectedLabel, forKey: "Preferred sport")
        for subview in tabView.arrangedSubviews {
            if let tabItemView = subview as? TabItemView {
                tabItemView.isSportSelected(tabItemView.getSportName() == UserDefaults.standard.object(forKey: "Preferred sport") as! String)
            }
        }
        
        eventsVC?.remove()
        eventsVC = nil
        eventsVC = EventsViewController(sport: SportType(rawValue: selectedLabel)!)
        add(eventsVC!, containerView: containerView)
        
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        eventsVC?.view.layer.add(animation, forKey: "viewControllerTransition")
        return self
    }
}
