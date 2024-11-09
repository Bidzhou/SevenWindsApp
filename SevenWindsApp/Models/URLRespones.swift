//
//  URLRespones.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let tokenLifetime: Int
    
}
