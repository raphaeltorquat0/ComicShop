//
//  CreatorsRequest.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public struct GetCreatorsViewModel: Model {
    public var data: Data?
    public var model: CreatorsModel?
    
    public init(data: Data? = nil) {
        self.data = data
    }
    
    public init(model: CreatorsModel) {
        self.model = model
    }
    
    public func toCreatorsViewModel( _ creatorsModel: CreatorsModel?) -> GetCreatorsViewModel? {
        guard let creatorsModel else { return nil }
        do {
            
            let creators = try CreatorsModel(from: creatorsModel as! Decoder)
            return GetCreatorsViewModel(model: creators)
        } catch {
            print("error:..\(error.localizedDescription)")
            return nil
        }
    }
}
