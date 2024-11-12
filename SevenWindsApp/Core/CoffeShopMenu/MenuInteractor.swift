//
//  MenuInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation

protocol MenuInteractorProtocol: AnyObject {
    var networkService: NetworkServiceProtocol {get}
}


class MenuInteractor: MenuInteractorProtocol {
    var networkService: any NetworkServiceProtocol = NetworkService()
    weak var presenter: MenuPresenterProtocol!
    
    required init(presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}
