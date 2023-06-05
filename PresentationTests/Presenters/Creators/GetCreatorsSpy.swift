//
//  GetCreatorsSpy.swift
//  PresentationTests
//
//  Created by Raphael Torquato on 04/06/23.
//

import Foundation
import Domain

class GetCreatorsSpy: GetCreators {
    var completion: ((GetCreators.Result) -> Void)?
    
    func getCreators(_ completion: @escaping (GetCreators.Result) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainErrors) {
        completion?(.failure(error))
    }
    
    func completeWithCreators(_ creators: CreatorsModel) {
        completion?(.success(creators))
    }
}
