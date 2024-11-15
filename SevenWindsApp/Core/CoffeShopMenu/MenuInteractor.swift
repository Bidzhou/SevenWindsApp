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
    func updatePositionCount(order: [Position], positions: inout [Position])
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
    
    func updatePositionCount(order: [Position],  positions: inout [Position]){
        for (index, oldPosition) in positions.enumerated() {
            if let updatedPosition = order.first(where: { $0.id == oldPosition.id }) {
                positions[index] = updatedPosition
            }
        }
    }
    
    

}
