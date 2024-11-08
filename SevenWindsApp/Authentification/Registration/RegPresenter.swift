//
//  RegPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import UIKit

protocol RegViewProtocol: AnyObject {
    func success()
    func failure()
   
}

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
            view.success()
            
        } else {
            view.failure()
        }
        router.goToAuthScreen()
        
    }
    

    
    init(view: RegViewProtocol!) {
        self.view = view
    }

    
    
}
