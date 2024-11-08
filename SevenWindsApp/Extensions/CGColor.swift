//
//  CGColor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import UIKit


extension CGColor {
   static let authTheme = cgColors()
}

struct cgColors {
    let buttonBorder = UIColor(named: "buttonBorder")!.cgColor
    let textField = UIColor(named: "authDarkBrown")!.cgColor
}
