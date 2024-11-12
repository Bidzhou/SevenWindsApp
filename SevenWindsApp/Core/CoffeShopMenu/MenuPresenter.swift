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
    func getPositions()
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ())
    
}

class MenuPresenter: MenuPresenterProtocol {
    var positions: [Position]? = nil
    var interactor: MenuInteractorProtocol!
    weak var view: MenuViewProtocol!
    
    required init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func getPositions() {
        interactor.networkService.getMenu(with: view.shop?.id ?? 0) {[weak self] result in
            DispatchQueue.main.async { 
                switch result {
                case .success(let positionArray):
                    self?.positions = positionArray
                    self?.view.success()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

        }
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        interactor.networkService.getImage(url: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    
}
