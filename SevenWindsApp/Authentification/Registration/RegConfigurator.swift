//
//  RegConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import UIKit


protocol RegConfiguratorProtocol: AnyObject {
    func configure(with viewController: RegViewController)
}

class RegConfigurator: RegConfiguratorProtocol {
    func configure(with viewController:  RegViewController) {
        let presenter = RegPresenter(view: viewController)
        let interactor = RegInteractor(presenter: presenter)
        let router = RegRouter(currentViewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
        
    }
    
    
}
