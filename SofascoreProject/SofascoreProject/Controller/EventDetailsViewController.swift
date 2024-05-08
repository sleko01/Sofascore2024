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
