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
    let textFieldText = UIColor(named: "authLightBrown")! //#AF9479
    let labelText = UIColor(named: "authDarkBrown")! //#846340
    let buttonBackground = UIColor(named: "buttonBackground")! //#342D1A
    let buttonText = UIColor(named: "buttonText")! //#F6E5D1
    let navBackground = UIColor(named: "navBarColor")!
    
}

struct CoffeShopsThemeColors {
    let secondaryTextColor = UIColor(named: "authLightBrown")! //#AF9479
    let coffeShopTextColor = UIColor(named: "authDarkBrown")! // #846340
    let backgroundOfCoffeShop = UIColor(named: "bcCoffeShop")! // #F6E5D1
}
