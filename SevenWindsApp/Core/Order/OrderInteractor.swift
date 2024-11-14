//
//  OrderInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 14.11.2024.
//

import Foundation

protocol OrderInteractorProtocol {
    var networkingService: NetworkServiceProtocol {get}
    var order: [Position]? {get set}

}

class Orderinteractor: OrderInteractorProtocol {
    var order: [Position]? = nil
    weak var preseneter: OrderPresenterProtocol!
    
    init(preseneter: OrderPresenterProtocol!) {
        self.preseneter = preseneter
    }
    
    var networkingService: any NetworkServiceProtocol = NetworkService()
    
}
