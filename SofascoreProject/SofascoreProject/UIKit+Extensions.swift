//
//  UIFont+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 20.03.2024..
//

import Foundation
import UIKit

public extension UIFont {
    
    static let robotoBold: UIFont = .init(name: "Roboto-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    static let robotoRegular: UIFont = .init(name: "Roboto-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    static let robotoCondensed: UIFont = .init(name: "Roboto-Condensed", size: 12) ?? UIFont.systemFont(ofSize: 12)
}

public extension UIColor {
    
    static let black: UIColor = .init(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    static let grey: UIColor = .init(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
    static let red: UIColor = .init(red: 233/256, green: 48/256, blue: 48/256, alpha: 1)
}
