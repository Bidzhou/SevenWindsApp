//
//  MapPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 18.11.2024.
//

import Foundation
import CoreLocation

protocol MapPresenterProtocol: AnyObject {
    func goToCoffeShop(shop: CoffeShop)
    func goBack()
    func getClosestShop(location: CLLocation, shops: [CoffeShop]) -> CLLocation?
}


class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewProtocol!
    var router: MapRouterProtocol!
    var interactor: MapInteractorProtocol!
    
    
    init(view: MapViewProtocol!) {
        self.view = view
    }
    
    func getClosestShop(location: CLLocation, shops: [CoffeShop]) -> CLLocation? {
        interactor.getClosestShop(location: location, shops: shops)
    }
    
    func goToCoffeShop(shop: CoffeShop) {
        router.goToCoffeShop(shop: shop)
    }
    
    func goBack() {
        router.goBack()
    }
    
   
    
    
}
