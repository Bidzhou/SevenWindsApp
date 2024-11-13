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
        
        presenter.interactor = interactor
        presenter.getPositions()
        viewController.presenter = presenter
    }
    
    
    
}
