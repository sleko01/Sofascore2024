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
    
    private var eventId: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        styleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func addViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func styleViews() {
        title = "Event \(eventId)"
    }
}

extension EventDetailsViewController {
    @discardableResult
    func eventId(_ id: Int) -> Self {
        self.eventId = id
        return self
    }
}
