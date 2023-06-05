//
//  CreatorsRequest.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public struct GetCharactersViewModel: Model {
    public var data: Data?
    public var model: CharactersModel?

    public init(data: Data? = nil) {
        self.data = data
    }

    public init(model: CharactersModel) {
        self.model = model
    }

    public func toCharactersViewModel(_ charactersModel: CharactersModel?) -> GetCharactersViewModel? {
        guard let charactersModel else { return  nil }
        do {
            let characters = try CharactersModel(from: charactersModel as! Decoder)
            return GetCharactersViewModel(model: characters)
        } catch {
            print("error:..\(error.localizedDescription)")
            return nil
        }
    }
}
