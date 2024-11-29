//
//  CoffeShop.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 10.11.2024.
//

import Foundation

struct CoffeShop: Codable {
    let id: Int
    let name: String
    let point: Location
}

struct Location: Codable {
    let latitude: String
    let longitude: String
    

}
