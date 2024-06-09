//
//  UIFont+Extensions.swift
//  SofascoreProject
//
//  Created by Sven Leko on 20.03.2024..
//

import Foundation
import UIKit


extension UIFont {
    
    static let headline1Desktop = UIFont(name: "Roboto-Bold", size: 32.0)
    static let headline1 = UIFont(name: "Roboto-Bold", size: 20.0)
    static let headline2 = UIFont(name: "Roboto-Bold", size: 16.0)
    static let action = UIFont(name: "Roboto-Bold", size: 16.0)
    static let headline3 = UIFont(name: "Roboto-Bold", size: 14.0)
    static let tabular = UIFont(name: "RobotoCondensed-Regular", size: 14.0)
    static let bodyParagraph = UIFont(name: "Roboto-Regular", size: 14.0)
    static let body = UIFont(name: "Roboto-Regular", size: 14.0)
    static let assistive = UIFont(name: "Roboto-Bold", size: 12.0)
    static let micro = UIFont(name: "RobotoCondensed-Regular", size: 12.0)
}

extension UIColor {
    
    static let black: UIColor = .init(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
    static let grey: UIColor = .init(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
    static let red: UIColor = .init(red: 233/256, green: 48/256, blue: 48/256, alpha: 1)
    static let blue: UIColor = .init(red: 55/256, green: 77/256, blue: 245/256, alpha: 1)
    static let colorPrimaryVariant: UIColor = .init(red: 19.0 / 255.0, green: 39.0 / 255.0, blue: 186.0 / 255.0, alpha: 1)
    static let colorSecondaryVariant: UIColor = .init(red: 221.0 / 255.0, green: 219.0 / 255.0, blue: 201.0 / 255.0, alpha: 1)
    static let colorPrimaryDefault: UIColor = .init(red: 55.0 / 255.0, green: 77.0 / 255.0, blue: 245.0 / 255.0, alpha: 1)
    static let colorSecondaryDefault: UIColor = .init(red: 240.0 / 255.0, green: 238.0 / 255.0, blue: 223.0 / 255.0, alpha: 1)
    static let colorPrimaryHighlight: UIColor = .init(red: 225.0 / 255.0, green: 237.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)
    static let colorSecondaryHighlight: UIColor = .init(red: 247.0 / 255.0, green: 246.0 / 255.0, blue: 239.0 / 255.0, alpha: 1)
    static let onColorOnColorPrimary: UIColor = .init(white: 1.0, alpha: 1)
    static let surfaceSurface1: UIColor = .init(white: 1.0, alpha: 1)
    static let surfaceSurface0: UIColor = .init(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 248.0 / 255.0, alpha: 1)
    static let surfaceSurface2: UIColor = .init(red: 192.0 / 255.0, green: 207.0 / 255.0, blue: 228.0 / 255.0, alpha: 0.2)
    static let onSurfaceOnSurfaceLv1: UIColor = .init(white: 18.0 / 255.0, alpha: 1)
    static let onColorOnColorSecondary: UIColor = .init(white: 1.0, alpha: 0.6)
    static let onSurfaceOnSurfaceLv2: UIColor = .init(white: 18.0 / 255.0, alpha: 0.4)
    static let onSurfaceOnSurfaceLv3: UIColor = .init(white: 18.0 / 255.0, alpha: 0.2)
    static let onSurfaceOnSurfaceLv4: UIColor = .init(white: 18.0 / 255.0, alpha: 0.1)
    static let statusError: UIColor = .init(red: 234.0 / 255.0, green: 69.0 / 255.0, blue: 69.0 / 255.0, alpha: 1)
    static let statusAlert: UIColor = .init(red: 216.0 / 255.0, green: 177.0 / 255.0, blue: 39.0 / 255.0, alpha: 1)
    static let statusSuccess: UIColor = .init(red: 29.0 / 255.0, green: 168.0 / 255.0, blue: 109.0 / 255.0, alpha: 1)
    static let specificLive: UIColor = .init(red: 233.0 / 255.0, green: 48.0 / 255.0, blue: 48.0 / 255.0, alpha: 1)
}
