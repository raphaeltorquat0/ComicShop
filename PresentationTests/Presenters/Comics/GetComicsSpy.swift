//
//  GetComicsSpy.swift
//  PresentationTests
//
//  Created by Raphael Torquato on 04/06/23.
//

import Foundation
import Domain

class GetComicsSpy: GetComics {
    var completion: ((GetComics.Result) -> Void)?
    
    func getCommicsModel(_ completion: @escaping (GetComics.Result) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithComics(_ comics: ComicsModel) {
        completion?(.success(comics))
    }
}
