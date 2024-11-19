//
//  MapConfigurator.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 18.11.2024.
//

import Foundation
protocol MapConfiguratorProtocol: AnyObject {
    func configure(with viewController: MapViewController)
}


class MapConfigurator: MapConfiguratorProtocol {
    func configure(with viewController: MapViewController) {
        let presenter = MapPresenter(view: viewController)
        let router = MapRouter(view: viewController)
        let interactor = MapInteractor(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
}
