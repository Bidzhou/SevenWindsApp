//
//  ShopsRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation
import UIKit
import CoreLocation
protocol ShopsRouterProtocol: AnyObject {
    func goBack()
    func goToTheCoffeShop(_ shop: CoffeShop)
    func goToMap(currentLocation: CLLocation, shops: [CoffeShop])
}

class ShopsRouter: ShopsRouterProtocol {
    weak var view: ShopsViewProtocol!
    
    required init(view: ShopsViewProtocol!) {
        self.view = view
    }
    
    func goBack() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.popViewController(animated: true)
    }
    
    func goToTheCoffeShop(_ shop: CoffeShop) {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.pushViewController(MenuViewController(shop: shop), animated: true)
    }
    
    func goToMap(currentLocation: CLLocation, shops: [CoffeShop]) {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.pushViewController(MapViewController(currentLocation: currentLocation, shops: shops), animated: true)
    }
    
    
    
    
}
