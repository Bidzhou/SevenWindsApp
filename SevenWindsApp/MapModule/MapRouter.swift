//
//  MapRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 18.11.2024.
//

import Foundation
import UIKit

protocol MapRouterProtocol: AnyObject {
    func goToCoffeShop(shop: CoffeShop)
    func goBack()
}

class MapRouter: MapRouterProtocol {
    weak var view: MapViewProtocol!

    init(view: MapViewProtocol!) {
        self.view = view
    }
    
    func goToCoffeShop(shop: CoffeShop) {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.pushViewController(MenuViewController(shop: shop), animated: true)
    }
    
    func goBack() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.popViewController(animated: true)
    }
    
    
}
