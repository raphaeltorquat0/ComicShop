//
//  GetCharacters.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public protocol GetCharacters {
    typealias Result = Swift.Result<CharactersModel, DomainErrors>
    func getCharactersModel(_ charactersModel:CharactersModel, completion: @escaping(Result) -> Void)
}

public struct GetCharactersModel: GetData {
    public var hash: String
    public var ts: Date
    public var apikey: String
    
    public init(hash: String, ts: Date, apikey: String) {
        self.hash = hash
        self.ts = ts
        self.apikey = apikey
    }
}
