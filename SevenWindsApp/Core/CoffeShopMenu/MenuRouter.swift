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
    func goPay(order: [Position])
}

class MenuRouter: MenuRouterProtocol {
    weak var view: MenuViewProtocol!
    
    required init(view: MenuViewProtocol!) {
        self.view = view
    }
    
    func goBack() {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.popViewController(animated: true)
    }
    
    func goPay(order: [Position]) {
        guard let vc = view as? UIViewController else {return}
        vc.navigationController?.pushViewController(OrderViewController(order: order), animated: true)
    }
    
    
}
