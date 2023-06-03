//
//  CreatorsRequest.swift
//  Presentation
//
//  Created by Raphael Torquato on 02/06/23.
//

import Foundation
import Domain

public struct GetCreatorsRequest: Model {
    public var hash: String?
    public var ts: Date?
    public var apiKey: String?
    
    public init(hash: String? = nil, ts: Date? = nil, apiKey: String? = nil) {
        self.hash = hash
        self.ts = ts
        self.apiKey = apiKey
    }
    
    public func toCreatorsRequestModel() -> GetCreatorsModel? {
        guard let hash = self.hash,
              let ts = self.ts,
              let apiKey = self.apiKey else { return nil }
        do {
            return GetCreatorsModel(hash: hash, ts: ts, apikey: apiKey)
        }
    }
}
