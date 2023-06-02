//
//  AlamofireAdapter.swift
//  ComicShop
//
//  Created by Raphael Torquato on 01/06/23.
//

import Foundation
import Alamofire
import Data

public final class AlamofireAdapter: HTTPGetClient {
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        session.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.invalidValuePassedToFilter))
                case 400...499:
                    completion(.failure(.emptyParameter))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }
}

