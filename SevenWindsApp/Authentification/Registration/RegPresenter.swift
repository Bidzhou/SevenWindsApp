//
//  RegPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import UIKit


protocol RegPresenterProtocol: AnyObject {
    
    func regButtonClicked(email: String, pass: String, rePass: String)
}

class RegPresenter: RegPresenterProtocol {

    weak var view: RegViewProtocol!
    var interactor: RegInteractorProtocol!
    var router: RegRouterProtocol!
    
    func regButtonClicked(email: String, pass: String, rePass: String) {
        guard !email.isEmpty, !pass.isEmpty, !rePass.isEmpty else {return}
        
        if interactor.checkValidation(pass: pass, rePass: rePass){
            interactor.networkService.registration(with: email, and: pass) { [weak self] registrationResponse in
                switch registrationResponse {
                case .success(let data):
                    print("Регистрация прошла успешно \n \(data)")
                    self?.router.goToAuthScreen()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            print("not valid")
        }
        
        
    }

    init(view: RegViewProtocol!) {
        self.view = view
    }

    
    
}
