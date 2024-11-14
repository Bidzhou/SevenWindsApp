//
//  OrderPresenter.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 14.11.2024.
//

import Foundation
protocol OrderPresenterProtocol: AnyObject {
    func goBack()
    var order: [Position]? {get set}
    func orderButtinTapped()
}

class OrderPresenter: OrderPresenterProtocol {
    var order: [Position]? = nil
    var router: OrderRouterProtocol!
    var interactor: OrderInteractorProtocol!
    weak var view: OrderViewProtocol!
    
    required init(view: OrderViewProtocol) {
        self.view = view
    }
    
    func goBack() {
        router.goBack()
    }
    
    func orderButtinTapped() {
        print(order?.description ?? "no order")
    }
}
