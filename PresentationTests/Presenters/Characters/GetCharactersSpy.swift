//
//  GetCharacrtersSpy.swift
//  PresentationTests
//
//  Created by Raphael Torquato on 04/06/23.
//

import Foundation
import Domain

class GetCharactersSpy: GetCharacters {
    var completion: ((GetCharacters.Result) -> Void)?
    
    func getCharactersModel(_ completion: @escaping (GetCharacters.Result) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithCharacters(_ characters: CharactersModel) {
        completion?(.success(characters))
    }
}
