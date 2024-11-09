//
//  NetworkService.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation
import Alamofire


/*
{"login":"Example@example.ru","password":"Qwerty123"}
"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjE3NjMsImV4cCI6MTczMTEwMjA0NH0.btyUOBFp3xwNedH-d0qk91LdF3mJn9Daj1MIOWvkJAI","tokenLifetime":3600000
 */
protocol NetworkServiceProtocol {
    func registration(with login: String, and pass: String, completion: @escaping (Result<AuthResponse, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {

    
 
    
//    func regPostRequest(with login: String, and pass: String) {
//        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json")]
//        let patametrs = ["login": login, "password": pass]
//        
//        AF.request(
//            "http://147.78.66.203:3210/auth/register",
//            method: .post,
//            parameters: patametrs,
//            encoding: JSONEncoding.default,
//            headers: headers
//        ).responseDecodable(of: AuthResponse.self) { response in
//            switch response.result {
//                
//            case .success(let data):
//                    print(data)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            debugPrint(response)
//            
//        }
//    }
    
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
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
