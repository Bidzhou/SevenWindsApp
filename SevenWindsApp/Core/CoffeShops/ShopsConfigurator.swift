//
//  ShopsConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation
protocol ShopsConfiguratorProtocol: AnyObject {
    func configure(with viewController: ShopsViewController)
}

class ShopsConfigurator: ShopsConfiguratorProtocol {
    func configure(with viewController: ShopsViewController) {
        let presenter = ShopsPresenter(view: viewController)
        let interactor = ShopsInteractor(presenter: presenter)
        let router = ShopsRouter(view: viewController)
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.getAllCoffeShops()
        viewController.presenter = presenter
    }
    
    
}
