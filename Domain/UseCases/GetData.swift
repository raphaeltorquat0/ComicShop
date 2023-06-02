//
//  GetData.swift
//  ComicVerseDomain
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation


public protocol GetData: Codable, Equatable, Model  {
    var apikey: String { get set }
    var hash: String { get set }
    var ts: Date { get set }
}

