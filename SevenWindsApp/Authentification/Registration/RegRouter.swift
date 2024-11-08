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
    
    weak var currentViewController: UIViewController!
    let authViewController: UIViewController
    
    init(currentViewController: UIViewController, authViewController: UIViewController) {
        self.currentViewController = currentViewController
        self.authViewController = authViewController
    }
    
    func goToAuthScreen() {
        currentViewController.navigationController?.pushViewController(authViewController, animated: true)
    }
    
    
}
