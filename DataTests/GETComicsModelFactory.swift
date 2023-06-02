//
//  GETComicsModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import Domain

func makeCommicsModel() -> CommicsModel? {
    
    do {
        guard let comics = try LoadLocal.loadBundleContentComics() else { return nil }
        return comics
    } catch {
        print("error:\(error.localizedDescription)")
    }
    return nil
}

func getComicsModel() -> GetCommicsModel {
    return GetCommicsModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}
