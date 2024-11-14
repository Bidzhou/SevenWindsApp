//
//  MenuInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation

protocol MenuInteractorProtocol: AnyObject {
    var networkService: NetworkServiceProtocol {get}
    func setOrder(allPositions: [Position]) -> [Position]
}


class MenuInteractor: MenuInteractorProtocol {
    var networkService: any NetworkServiceProtocol = NetworkService()
    weak var presenter: MenuPresenterProtocol!
    
    required init(presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func setOrder(allPositions: [Position]) -> [Position] {
        var order: [Position] = []
        for position in allPositions {
            if position.count != 0 {
                order.append(position)
            }
        }
        return order
    }
    
}
