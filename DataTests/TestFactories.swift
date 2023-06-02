//
//  TestFactories.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation

func makeEmptyData() -> Data {
    return Data()
}

func makeURL(theme: String) -> URL {
    let apiKey = ""
    let ts = ""
    let hash = ""
    
    return URL(string: "http://gateway.marvel.com/v1/public/\(theme)?ts=\(ts)&apikey=\(apiKey)&hash=\(hash)")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(theme: "comics"), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
