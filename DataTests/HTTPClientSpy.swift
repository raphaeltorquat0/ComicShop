//
//  HTTPClientSpy.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation

class HTTPClientSpy: HTTPGetClient {
    
    var urls = [URL]()
    var completion: ((Result<Data?, HTTPError>) -> Void)?
    
    func get(to url: URL, completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        self.urls.append(url)
        self.completion = completion
    }
    
    func completeWithError(_ error: HTTPError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
    
     public func getComics() -> Data? {
        
         do {
             let comics = try LoadLocal.loadBundleContentComics()
             return comics?.toData()
         } catch {
             print("error..\(error.localizedDescription)")
             return nil
         }
    }
    
     public func getCharacters() -> Data? {
         do {
             let characters = try LoadLocal.loadBundleContentCharacters()
             return characters?.toData()
             
         } catch {
             print("error..\(error.localizedDescription)")
             return nil
         }
    }
    
    public func getCreators()  -> Data? {
        do {
            let creators =  try LoadLocal.loadBundleContentCreators()
            return creators?.toData()
        } catch {
            print("error..\(error.localizedDescription)")
            return nil
        }
    }
}
