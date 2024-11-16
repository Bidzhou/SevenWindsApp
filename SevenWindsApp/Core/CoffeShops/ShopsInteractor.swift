//
//  ShopsInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation
import CoreLocation
protocol ShopsInteractorProtocol: AnyObject {
    var networkingService: NetworkServiceProtocol {get}
    func setLocations(shops: [CoffeShop]) -> [CLLocation]
    
}

class ShopsInteractor: ShopsInteractorProtocol {
    weak var presenter: ShopsPresenterProtocol!
    
    let networkingService: any NetworkServiceProtocol = NetworkService()
    
    required init(presenter: ShopsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setLocations(shops: [CoffeShop]) -> [CLLocation] {
        let locations: [CLLocation] = shops.map({CLLocation(latitude: Double($0.point.latitude) ?? 55.7558 , longitude: Double($0.point.longitude) ?? 37.6173)})
        return locations
    }
    
    
    
    
    
    
}
