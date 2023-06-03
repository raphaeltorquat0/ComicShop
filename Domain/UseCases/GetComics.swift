//
//  GetCommics.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public protocol GetComics {
    typealias Result = Swift.Result<ComicsModel, DomainErrors>
    func getCommicsModel(_ completion: @escaping(Result) -> Void)
}

public struct GetCommicsModel: GetData {
    public var hash: String
    public var ts: Date
    public var apikey: String
    
    public init(hash: String, ts: Date, apikey: String) {
        self.hash = hash
        self.ts = ts
        self.apikey = apikey
    }
}


