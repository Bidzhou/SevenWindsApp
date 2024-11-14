//
//  MenuConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation
protocol MenuConfiguratorProtocol: AnyObject {
    func configure(with viewController: MenuViewController)
}

class MenuConfigurator: MenuConfiguratorProtocol{
    func configure(with viewController: MenuViewController) {
        let presenter = MenuPresenter(view: viewController)
        let interactor = MenuInteractor(presenter: presenter)
        let router = MenuRouter(view: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.getPositions()
        viewController.presenter = presenter
    }
    
    
    
}
