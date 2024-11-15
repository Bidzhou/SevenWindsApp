//
//  AuthRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 7.11.2024.
//

import Foundation
import UIKit

protocol AuthRouterProtocol: AnyObject {
    func jumpToCoffeShops()
    func goBack()
}

class AuthRouter: AuthRouterProtocol {

    
    weak var view: AuthViewProtocol!
    required init(view: AuthViewProtocol) {
        self.view = view
    }
    func jumpToCoffeShops() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.pushViewController(ShopsViewController(), animated: true)
    }
    
    func goBack() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.popViewController(animated: true)
    }
    
}
