//
//  RegRouter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import UIKit

protocol RegRouterProtocol: AnyObject {
    func goToAuthScreen()
}

class RegRouter: RegRouterProtocol {
    
    weak var currentViewController: RegViewProtocol!

    
    init(currentViewController: RegViewProtocol) {
        self.currentViewController = currentViewController
        
    }
    
    func goToAuthScreen() {
        guard let viewController = currentViewController as? UIViewController else {return}
        viewController.navigationController?.pushViewController(AuthViewController(), animated: true)
    }
    
    
}
