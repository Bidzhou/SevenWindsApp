//
//  OrderConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 14.11.2024.
//

import Foundation
protocol OrderConfiguratorProtocol: AnyObject {
    func configure(with viewController: OrderViewController)
}

class OrderConfigurator: OrderConfiguratorProtocol {
    
    func configure(with viewController: OrderViewController){
        let presenter = OrderPresenter(view: viewController)
        let interactor = Orderinteractor(preseneter: presenter)
        let router = OrderRouter(view: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }

    
}
