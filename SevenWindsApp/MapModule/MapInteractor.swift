//
//  MapInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 18.11.2024.
//

import Foundation
import CoreLocation

protocol MapInteractorProtocol: AnyObject {
    func getClosestShop(location: CLLocation, shops: [CoffeShop]) -> CLLocation?
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol!
    
    init(presenter: MapPresenterProtocol!) {
        self.presenter = presenter
    }
    
    func getClosestShop(location: CLLocation, shops: [CoffeShop]) -> CLLocation? {
        var closestLocation: CLLocation? = nil
        var shortestDistance: CLLocationDistance = .greatestFiniteMagnitude

        for shop in shops {
            guard let latitude = Double(shop.point.latitude),
                  let longitude = Double(shop.point.longitude) else { continue }
            
            let shopLocation = CLLocation(latitude: latitude, longitude: longitude)
            print(shopLocation)
            let distance = location.distance(from: shopLocation)

            if distance < shortestDistance {
                shortestDistance = distance
                closestLocation = shopLocation
            }
        }

        return closestLocation
    }

    
    
    
    
}
