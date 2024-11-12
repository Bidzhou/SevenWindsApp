//
//  AuthPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import Foundation


protocol AuthPresenterProtocol: AnyObject {
    func enterButtonClicked(email: String, pass: String)
}

class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol!
    var interactor: AuthInteractorProtocol!
    var router: AuthRouterProtocol!
    
    
    required init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func enterButtonClicked(email: String, pass: String) {
        interactor.networkService.signIn(with: email, and: pass) {[weak self] authResponse in
            switch authResponse {
            
            case .success(let data):
                print(data)
                self?.router.jumpToCoffeShops()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
}
