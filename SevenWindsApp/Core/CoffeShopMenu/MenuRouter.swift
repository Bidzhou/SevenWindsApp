//
//  MenuRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation
import UIKit
protocol MenuRouterProtocol: AnyObject {
    func goBack()
    func goPay()
}

class MenuRouter: MenuRouterProtocol {
    weak var view: ShopsViewProtocol!
    
    required init(view: ShopsViewProtocol!) {
        self.view = view
    }
    
    func goBack() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.popViewController(animated: true)
    }
    
    func goPay() {
        print("goPay")
    }
    
    
}
