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
    
    /*
    [{
        "id":1,"name":"Арома","point":{"latitude":"44.43000000000000","longitude":"44.43000000000000"}
    },
     {
        "id":2,
        "name":"Кофе есть",
        "point":{"latitude":"44.72452500000000","longitude":"44.72452500000000"}
    },
     {"id":3,"name":"ЧайКофф","point":{"latitude":"44.83000000000000","longitude":"44.83000000000000"}}]
     */
}
