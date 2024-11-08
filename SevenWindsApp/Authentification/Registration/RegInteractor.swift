//
//  RegInteractor.swift
//  SevenWindsApp
//
//  Created by Frederico del' Bidzho on 8.11.2024.
//

import Foundation


protocol RegInteractorProtocol {
    func checkValidation(pass: String, rePass: String) -> Bool
}

class RegInteractor: RegInteractorProtocol {
    
    weak var presenter: RegPresenterProtocol!
    
    init(presenter: RegPresenterProtocol!) {
        self.presenter = presenter
    }
    
    func checkValidation(pass: String, rePass: String) -> Bool{
        var rangeFlag: Bool = false
        var upperCharFlag: Bool = false
        var lowerCharFlag: Bool = false
        var numFlag: Bool = false
        var passEquality: Bool = false
        
        if pass.count >= 6 {
            rangeFlag = true
        }
        
        if pass.rangeOfCharacter(from: .uppercaseLetters) != nil {
            upperCharFlag = true
        }
        
        if pass.rangeOfCharacter(from: .lowercaseLetters) != nil {
            lowerCharFlag = true
        }
        
        if pass.rangeOfCharacter(from: .decimalDigits) != nil {
            numFlag = true
        }
        
        if pass == rePass {
            passEquality = true
        }
        
        return rangeFlag && upperCharFlag && lowerCharFlag && numFlag && passEquality
    }
    
}
