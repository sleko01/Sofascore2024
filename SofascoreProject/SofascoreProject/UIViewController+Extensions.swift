//
//  UIViewController+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 11.04.2024..
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    
    func add(_ child: UIViewController, containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
