//
//  ComicsRequest.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public struct GetComicsViewModel: Model {
    public var data: Data?
    public var model: ComicsModel?
    
    public init(data: Data? = nil){
        self.data = data
    }
    
    public init(model: ComicsModel) {
        self.model = model
        
    }

    public func toComicsViewModel(_ comicsModel: ComicsModel?) -> GetComicsViewModel? {
        guard let comicsModel else { return nil }
        do {
            let comics = try ComicsModel(from: comicsModel as! Decoder)
            return GetComicsViewModel(model: comics)
        } catch {
            print("error...\(error.localizedDescription)")
            return nil
        }
    }
}
