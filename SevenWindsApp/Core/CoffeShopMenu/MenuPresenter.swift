//
//  MenuPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 11.11.2024.
//

import Foundation
import UIKit
protocol MenuPresenterProtocol: AnyObject {
    var positions: [Position]? {get set}
    var images: [UIImage]? {get set}
    func getPositions()
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ())
    func goBack()
    func goPay()
    func updatePositionCount(order: [Position],  positions: inout [Position])
    func onMinusButtonTapped(index: Int)
    func onPlusButtonTapped(index: Int)
}

class MenuPresenter: MenuPresenterProtocol {
    var positions: [Position]? 
    var images: [UIImage]? = nil
    var interactor: MenuInteractorProtocol!
    var router: MenuRouterProtocol!
    weak var view: MenuViewProtocol!
    
    required init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func goPay() {
        let order = interactor.setOrder(allPositions: positions ?? [Position]())
        guard !order.isEmpty else {return}
        router.goPay(order: order)
        
    }
    
    func getPositions() {
        interactor.networkService.getMenu(with: view.shop?.id ?? 0) {[weak self] result in
            DispatchQueue.main.async { 
                switch result {
                case .success(let positionArray):
                    self?.positions = positionArray.map({ position in
                        var tempPosition = position
                        tempPosition.count = 0
                        return tempPosition
                    })
                    self?.view.success()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        }
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        interactor.networkService.getImage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        }
    }
    
    func goBack() {
        router.goBack()
    }
    func updatePositionCount(order: [Position],  positions: inout [Position]) {
        self.interactor.updatePositionCount(order: order, positions: &positions)
    }
    
    func onMinusButtonTapped(index: Int)  {
        guard positions != nil, positions?[index].count != 0 else {return}
        positions?[index].count! -= 1
    }
    
    func onPlusButtonTapped(index: Int) {
        guard positions != nil, positions?[index].count != 9 else {return}
        positions?[index].count! += 1
    }
    
    
}
