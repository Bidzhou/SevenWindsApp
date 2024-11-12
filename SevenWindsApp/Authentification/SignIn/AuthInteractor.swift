//
//  AuthInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import Foundation


protocol AuthInteractorProtocol: AnyObject {
    var networkService: NetworkServiceProtocol {get}
}

class AuthInteractor: AuthInteractorProtocol {
    
    var networkService: any NetworkServiceProtocol = NetworkService()
    weak var presenter: AuthPresenterProtocol!
    
    required init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
    }
    
}
