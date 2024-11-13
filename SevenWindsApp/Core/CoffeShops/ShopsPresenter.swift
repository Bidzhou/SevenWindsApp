//
//  ShopsPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation

protocol ShopsPresenterProtocol: AnyObject {
    var coffeShops: [CoffeShop]? {get set}
    func getAllCoffeShops()
    func goToTheCoffeShop(_ shop: CoffeShop)
    func showOnMaps()
    func goBack()
}

class ShopsPresenter: ShopsPresenterProtocol {
    weak var view: ShopsViewProtocol!
    var coffeShops: [CoffeShop]? = nil
    var interactor: ShopsInteractorProtocol!
    var router: ShopsRouterProtocol!
    
    
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
    
    func showOnMaps() {
        print("maps")
    }
    
    func goBack() {
        router.goBack()
    }
    
    
}
