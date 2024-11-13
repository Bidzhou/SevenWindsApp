//
//  MenuModel.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation


struct Position: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Int
    var count: Int? = 0
}
