//
//  ShopsPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation
import CoreLocation

protocol ShopsPresenterProtocol: AnyObject {
    var coffeShops: [CoffeShop]? {get set}
    var locations: [CLLocation]? {get set}
    func getAllCoffeShops()
    func goToTheCoffeShop(_ shop: CoffeShop)
    func showOnMaps(currentLocation: CLLocation, shops: [CoffeShop])
    func goBack()
    func formatDistance(_ distanceInMeters: Double) -> String
}

class ShopsPresenter: ShopsPresenterProtocol {
    weak var view: ShopsViewProtocol!
    var coffeShops: [CoffeShop]? = nil
    var interactor: ShopsInteractorProtocol!
    var router: ShopsRouterProtocol!
    var locations: [CLLocation]? = nil
    
    required init(view: ShopsViewProtocol) {
        self.view = view
        //getAllCoffeShops()
    }
    
    
    func getAllCoffeShops() {
        
        interactor.networkingService.getLocations {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coffeShops):
                    self?.coffeShops = coffeShops
                    self?.locations = self?.interactor.setLocations(shops: coffeShops)
                    self?.view.successDownloadingData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        }
    }
    
    func goToTheCoffeShop(_ shop: CoffeShop) {
        
        router.goToTheCoffeShop(shop)
    }
    
    func showOnMaps(currentLocation: CLLocation, shops: [CoffeShop]) {
        router.goToMap(currentLocation: currentLocation, shops: shops)
    }
    
    func goBack() {
        router.goBack()
    }
    
    func formatDistance(_ distanceInMeters: Double) -> String {
        let distance = Measurement(value: distanceInMeters, unit: UnitLength.meters)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        
        
        if distanceInMeters >= 1000 {
            let distanceInKilometers = distance.converted(to: .kilometers)
            formatter.numberFormatter.maximumFractionDigits = 1
            return "\(formatter.string(from: distanceInKilometers)) от вас"
        } else {
            formatter.numberFormatter.maximumFractionDigits = 0
            return "\(formatter.string(from: distance)) от вас"
        }
    }

    
    
}
