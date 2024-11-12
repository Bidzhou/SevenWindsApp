//
//  ShopsInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 9.11.2024.
//

import Foundation

protocol ShopsInteractorProtocol: AnyObject {
    var networkingService: NetworkServiceProtocol {get}
    
}

class ShopsInteractor: ShopsInteractorProtocol {

    
    weak var presenter: ShopsPresenterProtocol!
    
    let networkingService: any NetworkServiceProtocol = NetworkService()
    
    
    required init(presenter: ShopsPresenterProtocol) {
        self.presenter = presenter
    }

    
    
}
