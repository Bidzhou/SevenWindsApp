//
//  OrderRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 14.11.2024.
//

import Foundation
import UIKit

protocol OrderRouterProtocol: AnyObject {
    func goBack()
}

class OrderRouter: OrderRouterProtocol {
    weak var view: OrderViewProtocol!
    
    required init(view: OrderViewProtocol) {
        self.view = view
    }
    
    func goBack() {
        func goBack() {
            guard let vc = view as? UIViewController else {return}
            vc.navigationController?.popViewController(animated: true)
        }
    }
    
}
