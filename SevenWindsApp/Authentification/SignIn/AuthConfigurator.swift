//
//  AuthConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import Foundation
import UIKit
protocol AuthConfiguratorProtocol: AnyObject {
    func configure(with viewController: AuthViewController)
}

class AuthConfigurator: AuthConfiguratorProtocol {
    func configure(with viewController: AuthViewController) {
        let presenter = AuthPresenter(view: viewController)
        let router = AuthRouter(view: viewController)
        let interactor = AuthInteractor(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
        
        
        
    }
    
    
}
