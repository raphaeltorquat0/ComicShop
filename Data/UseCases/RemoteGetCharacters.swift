//
//  RemoteGetCharacters.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation
import Domain

public final class RemoteGetCharacters: GetCharacters {
    private let url: URL
    private let httpClient: HTTPGetClient
    
    public init(url: URL, httpClient: HTTPGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func getCharactersModel(_ completion: @escaping (GetCharacters.Result) -> Void) {
        httpClient.get(to: url) { [weak self] result in
            switch result {
            case .success(let data):
                if let model: CharactersModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .emptyParameter:
                    completion(.failure(.invalidCredentials))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
