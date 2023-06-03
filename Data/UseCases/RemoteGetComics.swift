//
//  RemoteGetCommics.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation
import Domain

public final class RemoteGetComics: GetComics {
    public func getCommicsModel(_ completion: @escaping (GetComics.Result) -> Void) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: ComicsModel = data?.toModel() {
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
    
    private let url: URL
    private let httpClient: HTTPGetClient
    
    public init(url: URL, httpClient: HTTPGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
}
