//
//  Color.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import Foundation
import UIKit

extension UIColor {
    static let authTheme = ThemeColors()
    static let coffeShopsTheme = CoffeShopsThemeColors()
}

struct ThemeColors {
    let textFieldText = UIColor(named: "authLightBrown")!
    let labelText = UIColor(named: "authDarkBrown")!
    let buttonBackground = UIColor(named: "buttonBackground")!
    let buttonText = UIColor(named: "buttonText")!
    let navBackground = UIColor(named: "navBarColor")!
    
}

struct CoffeShopsThemeColors {
    let secondaryTextColor = UIColor(named: "authLightBrown")!
    let coffeShopTextColor = UIColor(named: "authDarkBrown")!
    let backgroundOfCoffeShop = UIColor(named: "bcCoffeShop")!
}
