//
//  NetworkService.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import Alamofire
import UIKit


/*
{
 "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjE4MTMsImV4cCI6MTczMTMxNTYxOH0.Yup3QzqeeHQP6TqgV912esFQuPOyqe1CyTFC51NQ2Jc"
 */
protocol NetworkServiceProtocol {
    func registration(with login: String, and pass: String, completion: @escaping (Result<AuthResponse, Error>) -> ())
    func signIn(with login: String, and pass: String, completion: @escaping (Result<AuthResponse, Error>) -> ())
    func getLocations(completion: @escaping (Result<[CoffeShop], Error>) -> ())
    func getMenu(with id: Int, completion: @escaping (Result<[Position], any Error>) -> ())
    func getImage(url: String, completion: @escaping (Result<UIImage, any Error>) -> ())
    
}

class NetworkService: NetworkServiceProtocol {
    
    

    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjE4MzEsImV4cCI6MTczMTQxNjM0N30.RfKU_c7ZQJq9WNV7i-NDBgszHP5-BGHG0R-RtT1AH-U"

    func registration(with login: String, and pass: String, completion: @escaping (Result<AuthResponse, any Error>) -> ()) {
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json")]
        let patametrs = ["login": login, "password": pass]
        
        AF.request(
            "http://147.78.66.203:3210/auth/register",
            method: .post,
            parameters: patametrs,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: AuthResponse.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
                print(data.token)
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }

 
    func signIn(with login: String, and pass: String, completion: @escaping (Result<AuthResponse, any Error>) -> ()) {
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json")]
        let parameters = ["login": login, "password": pass]
        
        AF.request("http://147.78.66.203:3210/auth/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: AuthResponse.self) { response in
            switch response.result {
                
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLocations(completion: @escaping (Result<[CoffeShop], any Error>) -> ()) {
        let headers: HTTPHeaders = [.accept("application/json"), .authorization(bearerToken:  token)]
       
        AF.request("http://147.78.66.203:3210/locations",encoding: JSONEncoding.default, headers: headers).responseDecodable(of: [CoffeShop].self) { response in
//            debugPrint(response)
            switch response.result {
            case .success(let coffeShops):
                completion(.success(coffeShops))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMenu(with id: Int, completion: @escaping (Result<[Position], any Error>) -> ()) {
        let headers: HTTPHeaders = [.accept("application/json"), .authorization(bearerToken: token)]
        AF.request("http://147.78.66.203:3210/location/\(id)/menu",encoding: JSONEncoding.default, headers: headers).responseDecodable(of: [Position].self) { response in
            debugPrint(response)
            switch response.result {
            case .success(let positionArray):
                completion(.success(positionArray))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, any Error>) -> ()) {
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let imgData):
                if let image = UIImage(data: imgData) {
                    completion(.success(image))
                } else {
                    completion(.success(UIImage(systemName: "circle")!))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }

}
